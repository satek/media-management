class MediaItemsController < ApplicationController

  def index
    @media_items =policy_scope(MediaItem).all
  end

  def new
    @item = MediaItem.new
    authorize @item
  end

  def create
    @item = MediaItem.new(media_item_params)
    @item.user = current_user
    authorize @item

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

  def destroy
    @media_item = MediaItem.find params['id']
    authorize @media_item
    @media_item.destroy

    respond_to do |format|
      format.html {
        redirect_to media_items_path, notice: 'Item was successfully destroyed.'
      }
    end
  end

  private

  def media_item_params
    params[:media_item].permit(:type, :title, :description)
  end

end
