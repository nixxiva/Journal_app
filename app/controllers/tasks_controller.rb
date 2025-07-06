class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_category
  before_action :set_task, except: [:new, :create]

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

  def edit

  end

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
    begin
      @category = @user.categories.find(params[:category_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "Category not found or you don't have an access."
      return
    end
  end

  def set_task
    begin
      @task = @category.tasks.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to user_category_tasks_path(@user, @category), alert: "Task not found"
      return
    end
  end

  def task_params
    params.require(:task).permit(:task_name, :definition, :due_date)
  end
end

