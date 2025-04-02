class StatusesController < ApplicationController
  before_action :find_task, only: %i[update ]
  
  def update
    if @task.update(status: params[:status])
      respond_to do |format|
          format.turbo_stream
      end
    end
  end

  private
  
  def find_task
    @task = Task.find(params[:id])
  end

end
