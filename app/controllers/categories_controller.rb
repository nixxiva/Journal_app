class CategoriesController < ApplicationController
  before_action :set_category, except: [:new, :create]

  def index
    @categories = current_user.categories.all
  end

  def show
  end

  def new
    @user = current_user
    @category = current_user.categories.build
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      flash[:notice] = "Category added"
      redirect_to @category
    else
      flash[:alert] = "Category cannot be added"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update  
  end

  def destroy
  end

  private

  def category_params
    params.require(:category).permit(:title, :body)
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  end
end
