class News < ApplicationRecord
  has_one_attached :image

  attr_accessor :remove_image

  before_save :purge_image_if_requested

  private

  def purge_image_if_requested
    if ActiveModel::Type::Boolean.new.cast(remove_image)
      image.purge_later
    end
  end
end