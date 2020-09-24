class SessionsController < ApplicationController
  def index
    #render json: {status: "It's working"}
    redirect_to root_path, success: "You have successfully logged ind!"
  end

  def create
    #Trys to authenticate the user with the email and password that comes along.
    user = User.find_by(email: params["user"]["email"]).try(:authenticate, params["user"]["password"])
    #If the user is successfully authenticated
    if user
      session[:user_id] = user.id
      session[:expires_at] = Time.current + 20.seconds
      render json: {status: :created, logged_in: true, user: user}
    else
      render json: {status: 401}
    end
  end

  def logged_in
    if @current_user
      render json: {logged_in: true, user: @current_user}
    else
      render json: {logged_in: false}
    end
  end

  def logout
    reset_session
    render json: {status: 200, logged_out: true}
  end
end

