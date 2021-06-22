module SessionsHelper

  def current_session
    Rails.cache.fetch("access_token/#{session[:user_id]}")
  end

  def signed_in?
    return false if session[:user_id].nil?
    return true if !current_session.nil?
    if Rails.cache.fetch("refresh_token/#{session[:user_id]}")
      refresh_session
      true
    else
      false
    end
  end

  def refresh_session
  end

  def sign_out
    Rails.cache.delete("access_token/#{session[:user_id]}")
    Rails.cache.delete("refresh_token/#{session[:user_id]}")
    session.delete(:user_id)
  end
end
