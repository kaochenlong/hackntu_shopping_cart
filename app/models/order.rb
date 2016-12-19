class Order < ApplicationRecord
  has_many :order_items

  validates :name, presence: true
  validates :tel, presence: true
end
