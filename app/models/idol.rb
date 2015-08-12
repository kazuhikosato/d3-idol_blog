class Idol < ActiveRecord::Base
  belongs_to :birthplace
  has_many :blogs
  has_many :idol_teams
  has_many :teams, through: :idol_teams
end
