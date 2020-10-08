class SessionsController < ApplicationController

  def create
    # Try's to authenticate the user with the email and password that come along.
    user = User.find_by(email: params["user"]["email"]).try(:authenticate, params["user"]["password"])
    # If the user is successfully authenticated,
    # a session cookie is created with the defined life span.
    if user
      session[:user_id] = user.id
      session[:expires_at] = Time.current + @@session_duration
      redirect_to home_home_path, success: "You have successfully logged in!"
    else
      # If the user couldn't be found a flash danger messages gets created.
      redirect_to sessions_index_path, danger: "Access denied, mismatching credentials"
    end
  end

  # Checks if a user is logged in.
  def logged_in
    if @current_user
      render json: {logged_in: true, user: @current_user}
    else
      render json: {logged_in: false}
    end
  end

  # Logs out a user.
  def logout
    reset_session
    redirect_to sessions_index_path, success: "You have successfully logged out."
  end
end

