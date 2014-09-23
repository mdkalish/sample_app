require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

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
  end
end

