class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, except: [:new, :create, :index]
  before_action :set_user

  def index
    @categories = @user.categories.all
  end

  def show
    @all_user_tasks = @user.tasks.order(due_date: :asc)
    @task = @category.tasks
    @category_tasks = @category.tasks.order(due_date: :asc)
  end

  def new
    @category = @user.categories.build
  end

  def create
    @category = @user.categories.build(category_params)
    if @category.save
      flash[:notice] = "Category added"
      redirect_to dashboard_path
    else
      flash[:alert] = "Category cannot be added"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = "Successfully updated category"
      redirect_to user_category_path(@user, @category)  
    else
      flash[:alert] = "Failed updating category. Please try again"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "Category deleted"
    redirect_to user_category_path(@user, @category)  
  end

  private

  def category_params
    params.require(:category).permit(:title, :body)
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def set_user
    @user = current_user
  end
end
