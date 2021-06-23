class VideosController < ApplicationController
  include RedirectHelper

  def index
    @videos = ZypeService.get_videos(order: 'desc')
  end

  def show
    id = params[:id]
    premium = params[:premium] == 'true'
    @video = { id: id, premium: premium }
    check_video_authorization(@video) if premium
    @video[:api_key] = Rails.application.credentials.zype[:api_key] if !premium
  end

  private

  def check_video_authorization(video)
    if signed_in?
      result = ZypeService.check_allowed_video(video[:id], current_session)
      video[:entitled] = result["message"] == "entitled"
    else
      set_return_point(request.url)
      redirect_to signin_path
    end
  end
end
