class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user  # Explicitly set @user to current_user
    @categories = @user.categories  # Categories for the current user
    @tasks = @user.tasks  # Tasks for the current user (if needed)
  end
end
