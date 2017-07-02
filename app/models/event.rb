class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :user
  has_many :ticket_types, autosave: true

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def local_starts_at
    self.starts_at.in_time_zone('Asia/Ho_Chi_Minh')
  end

  def local_ends_at
    self.ends_at.in_time_zone('Asia/Ho_Chi_Minh')
  end

  def nice_starts_at
    self.local_starts_at.strftime('%b %_m')
  end
  def nice_ends_at
    self.local_ends_at.strftime('%b %_m')
  end

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

  def have_enough_ticket_types?
    self.ticket_types.select{|t| t.max_quantity > 0 }.any?
  end

end
