if Rails.env == "production"
  #Defines the name of the cookie the session will create.
  Rails.application.config.session_store :cookie_store, key: "_fotoblog_authentication", domain: "localhost"
else
  Rails.application.config.session_store :cookie_store, key: "_fotoblog_authentication"
end

