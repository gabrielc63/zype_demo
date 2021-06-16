class ApiService

  def self.send_request(type:, url:, params: nil, api_header: nil)
    api_header = self.api_header
    if type == :post
      response = RestClient.post url, json_body, api_header
    elsif type == :get
      response = RestClient.get url, params: params
    elsif type == :patch
      response = RestClient.patch url, json_body, api_header
    elsif type == :delete
      response = RestClient.delete url, api_header
    end

    response
  rescue => e
    Rails.logger.error "#{e.message} #{e.backtrace.join("\n")}"
    raise e
  end

  def self.api_header()
    api_header = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    api_header
  end
end
