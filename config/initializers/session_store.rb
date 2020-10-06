if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: "_fotoblog_authentication", domain: "localhost"
else
  Rails.application.config.session_store :cookie_store, key: "_fotoblog_authentication"
end

