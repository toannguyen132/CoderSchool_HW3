class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :ticket_type
  validates :ticket_type, presence: true
  validates :quantity, numericality: {greater_than: 0}
end
