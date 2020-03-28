class Api::V1::IsFinishTasksController < ApplicationController
  def update
    begin
      permitted_params = permit_params()
      record = IsFinishTask.find_by(task_id: permitted_params[:task_id])
      record.update!(permitted_params)
      record = record.reload
      render json: { info: record }, status: 200
    rescue => e
      render json: { message: e.message }, status: 500
    end
  end

  private

  def permit_params
    params.permit(:task_id, :finish_type)
  end
end
