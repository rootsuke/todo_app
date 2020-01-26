class Api::V1::TasksController < ApplicationController
  def show
    begin
      tasks = Task.get
      render json: { info: tasks }, status: 200
    rescue => e
      render json: { info: e.message }, status: 500
    end
  end
end
