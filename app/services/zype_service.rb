class ZypeService
  API_URL = 'https://api.zype.com/videos'
  AUTH_URL = 'https://login.zype.com/oauth/token'

  def self.get_videos(order: 'asc')
    app_key = Rails.application.credentials.zype[:app_key]
    params = { app_key: app_key }
    response = ApiService.send_request(type: :get, url: API_URL, params: params)
    videos = JSON.parse(response)
    videos["response"]
  rescue JSON::ParserError, NoMethodError => e
    message = "error message: get videos #{e.message}, " \
              "req params: #{params}"
    Rails.logger.error message
    {}
  end

  def self.get_tokens(username:, password:)
    client_secret = Rails.application.credentials.zype[:client_secret]
    client_id = Rails.application.credentials.zype[:client_id]
    body = {
      "grant_type" => "password",
      "client_secret" => client_secret,
      "client_id" => client_id,
      "username" => username,
      "password" => password
    }

    response = ApiService.send_request(type: :post, url: AUTH_URL, params: body)
    tokens = JSON.parse(response)
    tokens
  rescue JSON::ParserError, NoMethodError => e
    message = "error message: get videos #{e.message}, " \
              "req params: #{params}"
    Rails.logger.error message
    {}
  end
end
