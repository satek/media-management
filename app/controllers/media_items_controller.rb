class MediaItemsController < ApplicationController

  def index
    @media_items = MediaItem.all
  end

  def new
    @item = MediaItem.new
  end

  def create
    @item = MediaItem.new(media_item_params)
    @item.user = current_user

    respond_to do |format|
      if @item.save
        format.html { 
          redirect_to @item, notice: 'Media item was successfully created.' 
        }
      else
        format.html { render :new }
      end
    end
  end

  private

  def media_item_params
    params[:media_item].permit(:type, :title, :description)
  end

end
