require 'test_helper'

class AppControllerTest < ActionDispatch::IntegrationTest
  test "should get app" do
    get app_app_url
    assert_response :success
  end

end
