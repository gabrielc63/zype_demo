class ApiService

  def self.send_request(type:, url:, params: nil, api_header: nil)
    api_header = self.api_header
    if type == :post
      response = RestClient.post url, params, api_header
    elsif type == :get
      response = RestClient.get url, params: params
    elsif type == :patch
      response = RestClient.patch url, params, api_header
    elsif type == :delete
      response = RestClient.delete url, api_header
    end

    response
  rescue RestClient::ExceptionWithResponse => e
    Rails.logger.error "#{e.message} url #{url} type #{type}"
    e.response
  end

  def self.api_header()
    api_header = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    api_header
  end
end
