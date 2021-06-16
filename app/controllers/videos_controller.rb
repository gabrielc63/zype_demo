class VideosController < ApplicationController
  def index
    @videos = ZypeService.get_videos(order: 'desc')
  end
end
