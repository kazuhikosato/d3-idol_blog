module TopHelper

  def get_team_blog affiliation_id
    idols = []
    blogs =[]
    Affiliation.find(affiliation_id).teams.each do |team|
      idols.concat(team.idols).uniq!
    end
    idols.each do |idol|
      idol_id = idol.id
      blogs.concat Blog.where('idol_id = ?', idol_id)
    end
    blogs.sort{ |a, b|
      b[:datetime] <=> a[:datetime]
    }
  end

end
