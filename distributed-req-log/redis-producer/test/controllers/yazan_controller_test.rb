require "test_helper"

class YazanControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get yazan_index_url
    assert_response :success
  end
end
