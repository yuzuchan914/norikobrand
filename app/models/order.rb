class Order < ApplicationRecord
  belongs_to :tweet

  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :card_number, presence: true

  # 数量は整数で1以上
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  
end
