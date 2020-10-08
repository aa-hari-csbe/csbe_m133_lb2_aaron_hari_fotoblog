class RegistrationsController < ApplicationController
  def registration

  end

  def create
    user = User.new(email: params['user']['email'],
                    password: params['user']['password'],
                    password_confirmation: params['user']['password_confirmation'],
                    username: params['user']['username'],
                    firstname: params['user']['firstname'],
                    lastname: params['user']['lastname'])
    if params['user']['image'] != nil
      user.image = params['user']['image']
    else
      file = File.open(@@default_profile_picture_path)
      user.image = file
      file.close
    end

    if user.save
      session[:user_id] = user.id
      session[:expires_at] = Time.current + @@session_duration
      redirect_to home_home_path, success: "You have successfully created a account!"
      #render json: {status: :created, user: user}
    else
      redirect_to registrations_registration_path, danger: "Either the email is already used or the passwords don't match."
      #render json: {status: 500}
    end
  end
end
