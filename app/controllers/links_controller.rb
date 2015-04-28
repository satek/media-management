class LinksController < ApplicationController

  before_action :set_link, only: [:show, :edit]
  before_action :set_media_item, only: [:new, :edit, :create]
  before_action :check_video_item_double_links, only: [:new, :create]

  def new
    @link = Link.new
  end

  def create
    @link = Link.new link_params
    @link.media_item = @media_item

    respond_to do |format|
      if @link.save
        format.html { 
          redirect_to @media_item, notice: 'Link successfully added.'
        }
      else
        format.html { 
          render :new
        }
      end
    end
  end

  private

  def set_link
    @link = Link.find params['id']
  end

  def set_media_item
    @media_item = MediaItem.find params['media_item_id']
  end

  def link_params
    params['link'].permit(:url)
  end

  def check_video_item_double_links
    return unless @media_item.is_video? and @media_item.has_link?
    redirect_to @media_item, notice: "Cannot add another link"
  end

end
