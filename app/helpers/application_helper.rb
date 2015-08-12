module ApplicationHelper
  def format_datetime datetime
    day_array = %w(日 月 火 水 木 金 土)
    day = datetime.wday
    datetime.strftime "%-m月%-d日(#{day_array[day]}) %H:%M"
  end


  def uniq_data array
    affiliations = []
    array.idol.teams.each do |team|
      affiliations << team.affiliation.name
    end
    affiliations.uniq
  end

  def get_button_class name
    team = Affiliation.find_by(name: name).id
    case team
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
end
