class IdolUser < ActiveRecord::Base
  belongs_to :idol
  belongs_to :user
  validates :user_id, presence: true
  validates :idol_id, presence: true
end
