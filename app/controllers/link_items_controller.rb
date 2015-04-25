class LinkItemsController < ApplicationController

  def show
    @item = LinkItem.find params['id']
  end

end
