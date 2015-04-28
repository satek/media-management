class MediaItemPolicy < ApplicationPolicy
  attr_reader :user, :media_item

  def initialize user, media_item
    @user = user
    @media_item = media_item
  end

  def new?
    true
  end

  def create?
    true
  end

  def show?
    @media_item.published or
    @user.id == @media_item.user.id
  end

  def update?
    @user.id == @media_item.user.id
  end

  def destroy?
    @user.id == @media_item.user.id
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where("user_id = ? or published= ?", user.id, true)
    end
  end
end
