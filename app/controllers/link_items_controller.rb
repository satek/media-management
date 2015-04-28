class LinkItemsController < ApplicationController
  before_action :set_link_item, only: [:show, :edit, :update]


  def show
  end

  def new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @item.update(link_item_params)
        format.html {
          redirect_to @item, notice: "Item was successfully updated"
        }
      else
        format.html
      end
    end
  end

  private

  def set_link_item
    @item = LinkItem.find params['id']
  end

  def link_item_params
    params['link_item'].permit(:title, :description)
  end

end
