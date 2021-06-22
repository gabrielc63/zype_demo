class SessionsController < ApplicationController
  include RedirectHelper

  def create
    username = params[:username]
    password = params[:password]
    result = ZypeService.get_tokens(username: username, password: password)
    if result["access_token"]
      session[:user_id] = username
      Rails.cache.fetch("access_token/#{username}", expires_in: result["expires_in"].seconds) do
        result["access_token"]
      end
      Rails.cache.fetch("refresh_token/#{username}", expires_in: 14.days) do
        result["refresh_token"]
      end
      flash[:success] = "Welcome"
      return_point
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url, notice: "Logged out!"
  end
end
