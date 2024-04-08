require "test_helper"

class V1::AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get v1_authentication_create_url
    assert_response :success
  end
end
