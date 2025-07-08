require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @category = categories(:one) 
    @task = tasks(:one)
  end

  test "should get index" do
    get user_category_tasks_path(@user, @category)
    assert_response :redirect
  end

  test "should get show" do
    get user_category_task_path(@user, @category, @task)
    assert_response :success
  end

  test "should get new" do
    get new_user_category_task_path(@user, @category)
    assert_response :success
  end

  test "should get create" do
    post user_category_tasks_path(@user, @category), params: {task: {task_name: "Test task name", definition: "test definition", due_date: "07-09-2025"}}
    assert_response :redirect
  end

  test "should get edit" do
    get edit_user_category_task_path(@user, @category, @task)
    assert_response :success
  end

  test "should get update" do
    patch user_category_task_path(@user, @category, @task), params: {task: {task_name: "Test task name", definition: "test definition", due_date: "07-09-2025"}}
    assert_response :redirect
  end

  test "should get destroy" do
    get user_category_task_path(@user, @category, @task)
    assert_response :success
  end
end
