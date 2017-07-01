class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :user
  has_many :ticket_types, autosave: true

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.published
    where(is_public: true)
  end

  def self.upcoming
    where("starts_at > ?", Time.now).order(starts_at: :asc )
  end

  def self.search(search_term)
    where("name ILIKE ?", "%#{search_term}%")
  end

  def self.posted_by(user_id)
    where(user_id: user_id)
  end

end
