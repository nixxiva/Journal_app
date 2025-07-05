class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = current_user.categories
    @tasks = current_user.tasks   
  end
end
