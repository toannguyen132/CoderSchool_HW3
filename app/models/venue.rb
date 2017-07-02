class Venue < ActiveRecord::Base
  belongs_to :region
  validates :name, presence: true
  validates_uniqueness_of :name
end
