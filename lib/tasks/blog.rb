$:.unshift File.dirname(__FILE__)
require 'crawler.rb'

class Blogs < Crawler
  attr_accessor :title, :name, :url, :datetime, :idol_id

  def format_datetime item
    DateTime.parse item
  end

  def get_idol_id item
    Idol.find_by(name: item).id
  end

  def encode_text text
    Rumoji.encode text
  end

  #親ページから情報をスクレイピングする関数
  def scrape_parent_contents item
    begin
      pp @title      = scrape_item(item, @site[:title_reg_pattern],        method(:encode_text))
      pp @url        = scrape_item(item, @site[:url_reg_pattern],          method(:format_url))
      pp @idol_id    = scrape_item(item, @site[:name_reg_pattern],         method(:get_idol_id))
      pp @datetime   = scrape_item(item, @site[:datetime_reg_pattern],     method(:format_datetime))
      save_content
    rescue=> e
      File.open 'log/error.log', 'a' do |f|
        f.puts "--------------------------"
        f.puts @title
        f.puts @url
        f.puts e.message
        f.puts e.backtrace
      end
      return
    end
  end

  def save_content
    if @title.present? && Blog.find_by(url: @url).nil?
      pp @title
      pp Blog.create(title: @title, url: @url, datetime: @datetime, idol_id: @idol_id)
    else
      return false
    end
  end

end
