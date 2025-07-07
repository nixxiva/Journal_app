class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @categories = @user.categories
    @tasks = @user.tasks
  end
end
