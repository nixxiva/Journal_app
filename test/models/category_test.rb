require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "should not save without title" do
    category = Category.new(body: "Test body")
    assert_not category.save
  end

  test "should not save without body" do
    category = Category.new(title: "Test body")
    assert_not category.save
  end

  test "should not save with < 5 chars " do
    category = Category.new(title: "Test title", body: "123")
    assert_not category.save
  end

  test "should save article with valid params" do
    category = Category.new(title: "Test title", body: "Test body", user: users(:one))
    assert category.save
  end
end
