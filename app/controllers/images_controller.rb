class ImagesController < ApplicationController
  before_action :set_image_item, only: [:new, :show, :edit, :create]

  def new
    @image = Image.new
    authorize @image
  end

  def create
    @image = Image.new image_params
    @image.image_item_id = @image_item.id
    authorize @image

    respond_to do |format|
      if @image.save
        format.html {
          redirect_to @image_item, notice: "Image was successfully uploaded"
        }
      else
        format.html {
          render :new
        }
      end
    end
  end

  private

  def image_params
    params.require('image').permit(:image_name, :image)
  end

  def set_image_item
    @image_item = ImageItem.find params['image_item_id']
  end
  
end
