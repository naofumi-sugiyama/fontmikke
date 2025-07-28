require "test_helper"

class FontsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fonts_index_url
    assert_response :success
  end

  test "should get show" do
    get fonts_show_url
    assert_response :success
  end
end
