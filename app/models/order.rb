class Order < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :order_items
  accepts_nested_attributes_for :order_items
end
