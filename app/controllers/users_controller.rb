class UsersController < ApplicationController
    # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end

    def show
        current_user = User.find(session[:user_id])
        render json: current_user, status: :created
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

    # def render_unprocessable_entity_response(e)
    #     render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    # end

    def record_not_found
        render json: { error: "Not Authorized" }, status: :unauthorized
    end
end
