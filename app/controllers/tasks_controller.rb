class TasksController < ApplicationController
  before_action :set_task, only: %i[ edit update destroy ]
  before_action :tasks_count, only: %i[ index update destroy]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
    @to_do_tasks = @tasks.where(status: 'to_do');
    @in_progress_tasks = @tasks.where(status: 'in_progress');
    @completed_tasks = @tasks.where(status: 'completed');
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @message = "Task was successfully created."
    respond_to do |format|
      if @task.save
        format.turbo_stream
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.turbo_stream
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.turbo_stream
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :status)
    end

    def tasks_count
      @tasks_count = Task.all.count
    end
end