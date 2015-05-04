class Image < ActiveRecord::Base
  dragonfly_accessor :image

  belongs_to :image_item

  validates :image, :image_item_id, presence: true

  delegate :user, to: :image_item

end
