class SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else
            render json: {errors: ["Username & Password combination is invalid"]}, status: :unauthorized
        end
    end

    def destroy
        if session[:user_id]
            session.delete :user_id
        else
            render json: {errors: ["You are not logged in"]}, status: :unauthorized
        end
    end
end
