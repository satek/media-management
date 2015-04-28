class LinkPolicy < ApplicationPolicy
  attr_reader :user, :link

  def initialize user, link
    @user = user
    @link = link
  end

  def new?
    @user.id == @link.media_item.user.id
  end

  def create?
    @user.id == @link.media_item.user.id
  end

  def show?
    @user.id == @link.media_item.user.id
  end

  def update?
    @user.id == @link.media_item.user.id
  end

end
