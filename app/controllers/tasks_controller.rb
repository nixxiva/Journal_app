class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_category
  before_action :set_task, except: [:new, :create]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key
  
  def index
    @task = @category.tasks.all
  end

  def show
    @all_user_tasks = @user.tasks.order(due_date: :asc)
  end

  def new
    @task = @user.tasks.build
  end

  def create
    @category = @user.categories.find(params[:category_id])

    @task = @category.tasks.build(task_params)
    if @task.save
      flash[:notice] = "Task added successfully"
      redirect_to user_category_path(@user, @category)
    else
      flash[:alert] = "Failed adding task, please try again."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      flash[:notice] = "Task updated successfully"
      redirect_to user_category_task_path(@user, @category, @task)
    else
      flash[:alert] = "Task failed to update, please try again."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.destroy
      flash[:notice] = "Task sucessfully deleted!"
      redirect_to user_category_path(@user, @category, @task)
    else
      flash[:alert] = "Cannot delete task."
      redirect_to user_category_task_path(@user, @category, @task)
    end
  end

  private 

  def set_user
    @user = current_user
  end

  def set_category
    @category = @user.categories.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:task_name, :definition, :due_date)
  end

  def record_not_found
    flash[:alert] = "Task does not exist."
    redirect_to user_category_path(current_user, @category)
  end

  def invalid_foreign_key
    flash[:alert] = "Invalid."
    redirect_to user_category_task_path(current_user, @category, @task)
  end
end

