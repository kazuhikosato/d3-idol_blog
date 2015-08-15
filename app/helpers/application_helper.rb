module ApplicationHelper
  def format_datetime datetime
    day_array = %w(日 月 火 水 木 金 土)
    day = datetime.wday
    datetime.strftime "%-m月%-d日(#{day_array[day]}) %H:%M"
  end

  def format_datetime_add_year datetime
    day_array = %w(日 月 火 水 木 金 土)
    day = datetime.wday
    datetime.strftime "%Y年%-m月%-d日(#{day_array[day]}) %H:%M"
  end

  def format_datetime_smart_phone datetime
    datetime.strftime "%H:%M"
  end

  def uniq_data array
    affiliations = []
    array.idol.teams.each do |team|
      affiliations << team.affiliation.name
    end
    affiliations.uniq
  end

  def get_affiliation affiliation_name
    Affiliation.find_by(name: affiliation_name)
  end

  def switch_class name
    affiliation = get_affiliation(name)
    case affiliation.id
    when 1
      "btn btn-red btn-xs"
    when 2
      "btn btn-yellow btn-xs"
    when 3
      "btn btn-green btn-xs"
    when 4
      "btn btn-black btn-xs"
    when 11
      "btn btn-purple btn-xs"
    when 12
      "btn btn-default btn-xs"
    else
      "btn btn-blue btn-xs"
    end
  end

  def get_path name
    affiliation = get_affiliation(name)
    case affiliation.id
    when 1
      "/akb"
    when 2
      "/ske"
    when 3
      "/nmb"
    when 4
      "/hkt"
    when 11
      "/nogizaka"
    when 12
      "/og"
    else
      "/"
    end
  end

  def get_team_path idol
    affiliations = []
    idol.teams.each do |team|
      affiliations << team.affiliation.name
    end
    get_path affiliations.shift
  end

  def get_favorite_idol user
    idols =[]
    IdolUser.where(user_id: user.id).each do |idol_user|
      idols << idol_user.idol
    end
    idols
  end
end
