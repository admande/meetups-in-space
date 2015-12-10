class Meetup < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  has_many :memberships
  has_many :users, :through => :memberships
  validates :name, presence: true, uniqueness: true
  validates :details, presence: true
  validates :location, presence: true
  validates :creator_id, presence: true
end
