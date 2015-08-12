class IdolTeam < ActiveRecord::Base
  belongs_to :idol
  belongs_to :team
end
