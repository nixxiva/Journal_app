class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @categories = @user.categories
    @tasks = @user.tasks
    @all_category = Category.all
    @tasks_today = Task.where(due_date: Date.today)
  end
end
