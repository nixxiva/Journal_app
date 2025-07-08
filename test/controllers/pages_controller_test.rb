require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user 
  end

  test "should get index" do
    get dashboard_path
    assert_response :success
  end
end
