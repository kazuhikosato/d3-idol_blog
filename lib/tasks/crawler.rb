require 'nokogiri'
require 'open-uri'
require 'kconv'
require 'time'
require 'pp'

class Crawler
  attr_accessor :site

  #文字列からスペースを取り除く関数
  def to_str nokogiri
    nokogiri.to_s.gsub(/\n|\s/, "")
  end

  #HTMLをノコギリでパースする関数
  def get_nokogiri url
    begin
      html = open(url).read.toutf8
    rescue
      puts "ノコギリエラー"
      return
    end
    Nokogiri.HTML(html)
  end

  #ノコギリデータをxpathで解析し、取得したいデータのまとまりを取得する関数
  def to_xpath nokogiri, pattern
    nokogiri.xpath(pattern)
  end


  #取ってきたURLをURIかURLかを解析し、URLにする関数
  def format_url path
    uri = URI(path)
    uri.host
    if uri.host.nil?
      @site[:host_url] + path
    else
      path
    end
  end

  #取ってきた生年月日をDATE型へ変換する関数
  def format_birthday date
    #date.gsub! %r(\D), '.'
    #date.slice! -1
    Date.parse date
  end

  #取ってきた個々の詳細データを適切にフォーマットする関数
  def scrape_item item, pattern, format = nil
    parsed_item = to_str(item.xpath(pattern))
    return if parsed_item.empty?
    parsed_item = format.call(parsed_item) if format
    parsed_item
  end

  #取得したデータの配列をeachで回し、個々のデータを取得する関数
  def nokogiri_each url, pattern, func
    nokogiri = get_nokogiri(url)
    items = to_xpath(nokogiri, pattern)
    items.each do |item|
      func.call item
    end
  end

  #親ページから情報をスクレイピングする関数
  def scrape_parent_contents item
  end

  #子ページから情報をスクレイピングする関数
  def scrape_child_contents item
  end

  def crawl_start
    nokogiri_each @site[:base_url], @site[:parent_reg_pattern], method(:scrape_parent_contents)
  end

  def save_content
  end

end
