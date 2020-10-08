#White lists the domain "http://localhost:9292"
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:9292"
    #Defines how the client is allowed to communicate (for security reasons).
    resource "*", headers: :any, method: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end
end
