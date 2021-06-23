module SessionsHelper

  def current_session
    Rails.cache.fetch("access_token/#{session[:user_id]}")
  end

  def signed_in?
    return false if session[:user_id].nil?
    return true if !current_session.nil?
    refresh_token = Rails.cache.fetch("refresh_token/#{session[:user_id]}")
    if refresh_token
      refresh_session(refresh_token)
    else
      false
    end
  end

  def refresh_session(refresh_token)
    result = ZypeService.get_tokens(username: session[:user_id],
                                    password: "",
                                    grant_type: "refresh_token",
                                    refresh_token: refresh_token)
    if result["access_token"]
      Rails.cache.fetch("access_token/#{session[:user_id]}", expires_in: result["expires_in"].seconds) do
        result["access_token"]
      end
      true
    else
      false
    end
  end

  def sign_out
    Rails.cache.delete("access_token/#{session[:user_id]}")
    Rails.cache.delete("refresh_token/#{session[:user_id]}")
    session.delete(:user_id)
  end
end
