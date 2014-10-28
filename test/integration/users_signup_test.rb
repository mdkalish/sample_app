require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    # Because the deliveries array is global, we have to reset it in the setup
    #+method to prevent our code from breaking if any other tests deliver email
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information with account activation" do
    get signup_path
    name  = "Example User"
    email = "user@example.com"
    password = "password"
    assert_difference 'User.count', 1 do
      post users_path, user: { name:  name,
                               email: email,
                               password:              password,
                               password_confirmation: password }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    # Inside a test, you can access instance variables defined in the controller
    #+by using assigns with the corresponding symbol. For example, if the create
    #+action defines an @user variable, we can access it in the test using
    #+assigns(:user).
    # assigns lets us access instance variables in the corresponding action.
    #+For example, the Users controller’s create action defines an @user variable
    #+(Listing 10.19), so we can access it in the test using assigns(:user).
    assert_not user.activated?

    # Try not to log in before activation
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email:'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    # assert_not flash.nil?
  end
end
