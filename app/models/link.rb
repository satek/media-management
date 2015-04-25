class Link < ActiveRecord::Base
  
  validates :media_item_id, :url, :type, presence: true

  validate :type_correctness

  def types
    %W(VideoLink WebLink)
  end

  private

  def type_correctness
    errors.add(:type, "is not acceptable") unless types.include? type
  end

end
