require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael) # uses michael hash from fixture users.yml
  end

  test "login with invalid information" do # flash should appear only once
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert 'sessions/new'    
    get root_path
    assert flash.empty?
  end



    # 1. Visit the login path.
    # 2. Post valid information to the sessions path.
    # 3. Check if logged in successfully
    # 3. Verify that the login link disappears.
    # 4. Verify that a logout link appears
    # 5. Verify that a profile link appears. 
    # 6. Issue a DELETE request to the logout path.
    # 7. Verify that the user is logged out.
    # 8. and redirected to the root URL.
    # 9. Check that the login link reappers.
    # 10. Check that the logout and profile links dissappear.

  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user # check the right redirect target
    follow_redirect! # actually visit the target page
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0 # we expect 0 links
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

end
