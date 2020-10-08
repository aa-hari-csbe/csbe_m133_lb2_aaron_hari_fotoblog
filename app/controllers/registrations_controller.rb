class RegistrationsController < ApplicationController

  # Creates a new user.
  def create
    user = User.new(email: params['user']['email'],
                    password: params['user']['password'],
                    password_confirmation: params['user']['password_confirmation'],
                    username: params['user']['username'],
                    firstname: params['user']['firstname'],
                    lastname: params['user']['lastname'])
    if params['user']['image'] != nil
      # If the user has uploaded a profile picture,
      # it gets stored in the user variable.
      user.image = params['user']['image']
    else
      # If the user hasn't uploaded a profile picture,
      # the default profile picture gets stored in the user variable.
      file = File.open(@@default_profile_picture_path)
      user.image = file
      file.close
    end

    # Checks if the user can be saved,
    # and if so it does that.
    if user.save
      # Creates a session cookie for the user,
      # so he is instantly logged in.
      session[:user_id] = user.id
      session[:expires_at] = Time.current + @@session_duration
      redirect_to home_home_path, success: "You have successfully created a account!"
    else
      # If the user couldn't be saved a flash danger messages gets created.
      redirect_to registrations_registration_path, danger: "Either the email is already used or the passwords don't match."
    end
  end
end
