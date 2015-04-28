class Image < ActiveRecord::Base
  dragonfly_accessor :image

  belongs_to :image_item

  validates :image, presence: true


end
