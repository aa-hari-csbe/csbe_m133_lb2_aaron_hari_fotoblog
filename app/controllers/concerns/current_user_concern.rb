module CurrentUserConcern
  extend ActiveSupport::Concern

  # Calls set_current_user.
  included do
    before_action :set_current_user
  end

  # If an user is logged in, creates a the @current_user
  # which contains all important information about the
  # logged in user an it can be reach from every controller.
  def set_current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end
end
