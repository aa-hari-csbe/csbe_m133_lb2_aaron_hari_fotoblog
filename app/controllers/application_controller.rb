class ApplicationController < ActionController::Base
  included CurrentUserConcern
  skip_before_action :verify_authenticity_token
end
