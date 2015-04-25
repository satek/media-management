class VideoItemsController < ApplicationController

  def show
    @item = VideoItem.find params['id']
  end

end
