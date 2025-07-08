require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @category = categories(:one) 
  end

  test "should get index" do
    get user_categories_path(@user)
    assert_response :success
  end

  test "should get show" do
    get user_category_path(@user, @category)
    assert_response :success
  end

  test "should get new" do
    get new_user_category_path(@user)
    assert_response :success
  end

  test "should get create" do
    post user_categories_path(@user), params: {category: {title: "Test title", body: "test body"}}
    assert_response :redirect
  end

  test "should get edit" do
    get edit_user_category_path(@user, @category)
    assert_response :success
  end

  test "should get update" do
    patch user_category_path(@user, @category), params: {category: {title: "Test title", body: "test body"}}
    assert_response :redirect
  end

  test "should get destroy" do
    get user_category_path(@user, @category)
    assert_response :success
  end
end
