class ZypeService
  URL = 'https://api.zype.com/videos'

  def self.get_videos(order: 'asc')
    app_key = Rails.application.credentials.zype[:app_key]
    params = {app_key: app_key}
    response = ApiService.send_request(type: :get, url: URL, params: params)
    videos = JSON.parse(response)
    videos["response"]
  rescue JSON::ParserError, NoMethodError => e
    message = "error message: get videos #{e.message}, " \
              "req params: #{params}"
    Rails.logger.error message
    raise e
  end
end
