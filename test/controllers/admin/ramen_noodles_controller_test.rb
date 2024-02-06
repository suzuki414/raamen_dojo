require "test_helper"

class Admin::RamenNoodlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_ramen_noodles_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_ramen_noodles_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_ramen_noodles_edit_url
    assert_response :success
  end
end
