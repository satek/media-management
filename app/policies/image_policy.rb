class ImagePolicy < ApplicationPolicy
  attr_reader :user, :image

  def initialize user, image
    @user = user
    @image = image
  end

  def new?
    @user.id == @image.image_item.user.id
  end

  def create?
    @user.id == @image.image_item.user.id
  end

  def show?
    @user.id == @image.image_item.user.id
  end

  def update?
    @user.id == @image.image_item.user.id
  end

  def destroy?
    @user.id == @image.image_item.user.id
  end

end
