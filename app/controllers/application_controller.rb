class ApplicationController < ActionController::Base
  include CurrentUserConcern

  # CSRF token is skipped.
  # We authenticate the user in the require_login method.
  skip_before_action :verify_authenticity_token
  # Skips require_login for the pages
  # that you don't need to be logged in.
  before_action :require_login, except: [:index, :registration, :create]

  # Defines the Bootstrap flash types.
  add_flash_types :danger, :primary, :success

  # Global variable for the lifespan of a session.
  @@session_duration = 60.minutes
  # The path of the default profile picture.
  @@default_profile_picture_path = "/home/vm/workspace/fotoblog/app/assets/images/bilder/DSC00697-HDRB.JPG"

  private

  # Checks if a user is logged in, and there for has a valid session cookie.
  def require_login
    if @current_user
      # Checks if the session cookie of the user is expired or not.
      if session[:expires_at] < Time.current
        reset_session
        redirect_to sessions_index_path, danger: "Your session has expired"
      end
    else
      # If no user is logged in, creates a flash primary message.
      redirect_to sessions_index_path, primary: "Your not logged in"
    end
  end
end
