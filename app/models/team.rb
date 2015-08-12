class Team < ActiveRecord::Base
  belongs_to :affiliation
  has_many :idol_teams
  has_many :idols, through: :idol_teams
end
