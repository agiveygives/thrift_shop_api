require "test_helper"

class V1::AccountControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get v1_account_create_url
    assert_response :success
  end
end
