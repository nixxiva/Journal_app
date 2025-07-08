require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "should not save without task name" do
    task = Task.new(definition: "Test definition", due_date: "07-01-2025")
    assert_not task.save
  end

  test "should not save without definition" do
    task = Task.new(task_name: "Test task name", due_date: "07-01-2025")
    assert_not task.save
  end

  test "should not save without due date" do
    task = Task.new(definition: "Test definition", task_name: "Test task name")
    assert_not task.save
  end

  test "should not save with < 5 chars" do
    task = Task.new(task_name: "Test task name", definition: "123", due_date: "07-01-2025")
    assert_not task.save
  end

  test "should save task with valid params" do
    task = Task.new(task_name: "Test task name", definition: "Test definition", due_date: "07-09-2025", category: categories(:one))
    assert task.save
  end
end

