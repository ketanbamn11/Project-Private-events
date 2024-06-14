class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :event_attendances, foreign_key: :event_id, class_name: 'EventAttendee', dependent: :destroy
  has_many :attendees, through: :event_attendances, source: :user

  scope :past, -> { where('event_date < ?', Time.now) }
  scope :upcoming, -> { where('event_date >= ?', Time.now) }
end
