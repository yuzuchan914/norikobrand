class Tweet < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy

  has_one_attached :image

  # フォームからの仮属性を作る（画像削除用）
  attr_accessor :remove_image

  # 保存前に削除が指定されていれば画像を削除
  before_save :purge_image_if_requested

  private

  def purge_image_if_requested
    # チェックボックスがオンだったら画像を非同期で削除
    if ActiveModel::Type::Boolean.new.cast(remove_image)
      image.purge_later
    end
  end
end