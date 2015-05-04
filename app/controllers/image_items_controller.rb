class ImageItemsController < ApplicationController
  before_action :set_image_item, only: [:show, :edit, :update]

  def new
    authorize @image_item
  end

  def show
    @image = Image.new
    authorize @image_item
  end

  def edit
    authorize @image_item
  end

  def update
    authorize @image_item
    respond_to do |format|
      if @image_item.update(image_item_params)
        format.html {
          redirect_to @image_item, notice: "Item was successfully updated"
        }
      else
        format.html
      end
    end
  end

  private

  def set_image_item
    @image_item = ImageItem.find params['id']
  end

  def image_item_params
    params['image_item'].permit(:title, :description, :published)
  end

end
