class ApplicationController < ActionController::Base
  included CurrentUserConcern

  skip_before_action :verify_authenticity_token
  before_action :require_login, except: [:index, :registration, :create]

  add_flash_types :danger, :primary, :success


  private

  def require_login
    if @current_user
      if session[:expires_at] < Time.current
        #render json: {session: session, time: Time.current}
        reset_session
        redirect_to sessionhandling_welcome_path, danger: "You'r session has expired"
      end
    else
      redirect_to sessionhandling_welcome_path, primary: "You'r not logged in"
    end
  end

end
