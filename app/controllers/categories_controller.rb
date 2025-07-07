class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, except: [:new, :create, :index]
  before_action :set_user
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

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
      redirect_to user_categories_path(@user)
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
    redirect_to user_categories_path(@user)  
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

  def record_not_found
    flash[:alert] = "Category does not exist."
    redirect_to user_categories_path(current_user)
  end

  def invalid_foreign_key
    flash[:alert] = "Invalid."
    redirect_to user_category_path(current_user)
  end
end
