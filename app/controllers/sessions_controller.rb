class SessionsController < ApplicationController
  def index
    #render json: {status: "It's working"}
    #redirect_to sessions_index_path, success: "You have successfully logged ind!"
  end

  def create
    #Trys to authenticate the user with the email and password that comes along.
    user = User.find_by(email: params["user"]["email"]).try(:authenticate, params["user"]["password"])
    #If the user is successfully authenticated
    if user
      session[:user_id] = user.id
      session[:expires_at] = Time.current + @@session_duration
      redirect_to home_home_path, success: "You have successfully logged in!"
      #render json: {status: :created, logged_in: true, user: user}
    else
      redirect_to sessions_index_path, danger: "Access denied, mismatching credentials"
      #render json: {status: 401}
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
    redirect_to sessions_index_path, success: "You have successfully logged out."
    #render json: {status: 200, logged_out: true}
  end
end

