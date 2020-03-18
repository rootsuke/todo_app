class Api::V1::UsersController < ApplicationController
  def show
    begin
      users = User.all
      render json: { info: users }, status: 200
    rescue => e
      render json: { info: e.message }, status: 500
    end
  end
end

