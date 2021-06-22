class VideosController < ApplicationController
  include RedirectHelper

  def index
    @videos = ZypeService.get_videos(order: 'desc')
  end

  def show
    id = params[:id]
    premium = params[:premium] == 'true'
    if premium && !signed_in?
      set_return_point(request.url)
      redirect_to signin_path
    end
    @video = { id: id, premium: premium }
    @video[:api_key] = Rails.application.credentials.zype[:api_key] if !premium
  end
end
