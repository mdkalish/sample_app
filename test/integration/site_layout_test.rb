require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path    # Rails automatically inserts the
    assert_select "a[href=?]", help_path    #+value of x_path in place of the
    assert_select "a[href=?]", about_path   #+question mark.
    assert_select "a[href=?]", contact_path
    #+http://draft.railstutorial.org/book/filling_in_the_layout#code-layout_li
    #+nks_test
    # More uses of assert_select:
    #+http://draft.railstutorial.org/book/filling_in_the_layout#table-assert_s
    #+elect

    # 9.6 Exercises: 2
    # When not logged in:
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", "http://news.railstutorial.org/"
    assert_select "a[href=?]", user_path(@other_user), count: 0
    assert_select 'a.dropdown-toggle', count: 0
    # When logged in as a non-admin:
    log_in_as(@other_user)
    follow_redirect!
    assert_select "a[href=?]", users_path
    assert_select 'a.dropdown-toggle'
    assert_select "a[href=?]", user_path(@other_user)
    assert_select "a[href=?]", edit_user_path(@other_user)
    assert_select "a[href=?]", logout_path
    assert_select 'a', text: 'delete', count: 0
    # When logged in as an admin:
    log_in_as(@user)
    follow_redirect!
    get users_path
    assert_select 'a', text: 'delete'
    ##
  end
end

