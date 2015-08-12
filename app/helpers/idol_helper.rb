module IdolHelper

  def get_team_idol affiliation_id
    idols = []
    Affiliation.find(affiliation_id).teams.each do |team|
      idols.concat(team.idols).uniq!
    end
    idols.sort{ |a, b|
      a[:kana] <=> b[:kana]
    }
  end
end
