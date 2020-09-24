class SessionsController < ApplicationController
  def create
    #Trys to authenticate the user with the email and password that comes along.
    user = User.find_by(email: params["user"]["email"]).try(:authenticate, params["user"]["password"])
    #If the user is successfully authenticated
    if user
      session[:user_id] = user.id
      render json: {status: :created, logged_in: true, user: user}
    else
      render json: {status: 401}
    end
  end
end

