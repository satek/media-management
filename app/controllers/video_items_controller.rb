class VideoItemsController < ApplicationController
  before_action :set_video_item, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @video_item.update(video_item_params)
        format.html {
          redirect_to @video_item, notice: "Item was successfully updated"
        }
      else
        format.html
      end
    end
  end

  private

  def set_video_item
    @video_item = VideoItem.find params['id']
    authorize @video_item
  end

  def video_item_params
    params['video_item'].permit(:title, :description)
  end

end
