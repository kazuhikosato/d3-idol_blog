$:.unshift File.dirname(__FILE__)
require 'crawler.rb'

class Idols < Crawler
  attr_accessor :teams, :name, :kana, :image_url, :birthday, :birthplce, :url

  def scrape_kana item, pattern
    item.xpath(pattern).to_s
  end

  def format_team item
    team_array = []
    if item.index %r(・)
      item.split(%r(・))
    else
      team_array << item
    end
  end

  def get_birthplace_id item
    Birthplace.find_by(name: item).id
  end

  #親ページから情報をスクレイピングする関数
  def scrape_parent_contents item
    begin
      @teams      = scrape_item(item, @site[:team_reg_pattern], method(:format_team))
      @name       = scrape_item(item, @site[:name_reg_pattern])
      #@kana       = scrape_kana(item, @site[:kana_reg_pattern])
      #@image_url  = scrape_item(item, @site[:image_parent_reg_pattern], method(:format_url))
      #@birthday   = scrape_item(item, @site[:birthday_reg_pattern],     method(:format_birthday))
      #@birthplace = scrape_item(item, @site[:birthplace_reg_pattern], method(:get_birthplace_id))
      #@url        = scrape_item(item, @site[:url_reg_pattern],          method(:format_url))
      #nokogiri_each @image_url, @site[:child_reg_pattern], method(:scrape_child_contents) if @image_url
      #return if @url.nil? || @image_url.nil?
    rescue => ex
      puts ex.message
      puts ex.backtrace
      return
    end
    #save_content
    update_content if @name.present?
  end

  #子ページから情報をスクレイピングする関数
  def scrape_child_contents item
    @image_url = scrape_item(item, @site[:image_child_pattern], method(:format_url))
  end

  def save_content
    if @name.present? && Idol.find_by(name: @name).nil?
      pp idol = Idol.create(name: @name, kana: @kana, image_url: @image_url, birthday: @birthday, birthplace_id: @birthplace, url: @url)
      idol_team_associate idol
    else
      return false
    end
  end

  def update_content
    pp @name
    idol_id = Idol.find_by(name: @name).id
    @teams.each do |team|
      if team.include? "研"
        team = "AKB48 研究生"
        team_id = Team.find_by(name: team).id
        pp IdolTeam.create(idol_id: idol_id, team_id: team_id)
      end
    end
  end

  def idol_team_associate record
    idol_id = record.id
    @teams.each do |team|
      team_id = Team.find_by(name: team).id
      pp IdolTeam.create(idol_id: idol_id, team_id: team_id)
    end
  end
end
