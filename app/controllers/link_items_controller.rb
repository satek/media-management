class LinkItemsController < ApplicationController
  before_action :set_link_item, only: [:show, :edit, :update]


  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @link_item.update(link_item_params)
        format.html {
          redirect_to @link_item, notice: "Item was successfully updated"
        }
      else
        format.html
      end
    end
  end

  private

  def set_link_item
    @link_item = LinkItem.find params['id']
    authorize @link_item
  end

  def link_item_params
    params['link_item'].permit(:title, :description)
  end

end
