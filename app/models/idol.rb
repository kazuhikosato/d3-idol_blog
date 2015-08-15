class Idol < ActiveRecord::Base
  belongs_to :birthplace
  has_many :blogs
  has_many :idol_teams
  has_many :teams, through: :idol_teams
  has_many :idol_users
  has_many :users, through: :idol_users

  def favorite_for(user)
    idol_users.find_by(user_id: user)
  end
end
