class Order < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :order_items
  accepts_nested_attributes_for :order_items, reject_if: proc {|attributes| attributes['quanitty'] == 0}

  def purchase
  end
end
