class ApplicationController < ActionController::Base
  include CurrentUserConcern

  skip_before_action :verify_authenticity_token
  before_action :require_login, except: [:index, :registration, :create]

  add_flash_types :danger, :primary, :success

  private

  def require_login
    if @current_user
      if session[:expires_at] < Time.current
        #render json: {session: session, time: Time.current}
        reset_session
        redirect_to sessions_index_path, danger: "Your session has expired"
      end
    else
      redirect_to sessions_index_path, primary: "Your not logged in"
    end
  end
end
