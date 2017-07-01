class Order < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :order_items
  validates :event, presence: true
  accepts_nested_attributes_for :order_items, reject_if: proc {|attributes| attributes[:quantity].to_i == 0 }

  def purchase
  end
end
