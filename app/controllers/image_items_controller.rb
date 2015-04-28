class ImageItemsController < ApplicationController
  before_action :set_image_item, only: [:show, :edit, :update]


  def show
    @image = Image.new
  end

  def new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @image_item.update(image_item_params)
        format.html {
          redirect_to @item, notice: "Item was successfully updated"
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
    params['image_item'].permit(:title, :description)
  end

end
