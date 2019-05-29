class VideosController < ApplicationController
	def index
    zype = ZypeService.new
    @videos = zype.create_videos_from_api
  end

  def show
    zype = ZypeService.new
    videos = zype.create_videos_from_api
    @video = videos.detect{ |vid| vid.id == params['id']}
    if @video.subs && !logged_in?
      flash[:alert] = "You Must Login or Subscribe to continue"
      redirect_to '/sessions'
    end
  end
end
