namespace :crawl_judge do
  require 'nokogiri'
  require 'open-uri'
  require 'kconv'
  require 'time'
  require 'pp'

  desc "裁判官に関する情報をクローリングして取得"
  task :crawl_start => :environment do

    class Crawler
      attr_accessor :name, :url, :affiliation, :text, :site
      def initialize(site_name)
        settings = {
          judge: {
            host_url:            'http://www.e-hoki.com',
            base_url:            'http://www.e-hoki.com/judge/index_',
            parent_reg_pattern:  '/html/body/div/div[3]/table/tr/td[1]/div[contains(@class, "idx-area01")]',
            url_reg_pattern:     'table/tr/td[1]/p/a/@href',
            name_reg_pattern:    'table/tr/td[1]/p/a/text()',
            affiliation_reg_pattern: 'table/tr/td[2]/p/text()',
            child_reg_pattern:   '/html/body/div/div[3]/table/tr/td[1]/div[2]/table/tr[2]/td[2]/div/div/tt/text()',
            page_count:          1,
            pager_after_path:    '.html',
          },
        }

        @site = settings[site_name]
      end

      def to_str nokogiri
        nokogiri.to_s.gsub(/\r|\t|\s/, "")
      end

      #クローリング開始する関数
      def crawling_start
        page_num = 131

        while page_num
          parent_nokogiri = get_nokogiri_doc("#{@site[:base_url]}#{page_num}#{@site[:pager_after_path]}")
          scrape_urls_name_affiliation parent_nokogiri
          pp page_num += @site[:page_count]
        end
      end

      #親ページのHTMLをNOKOGIRIでパースする
      def get_nokogiri_doc url
        begin
          html = open(url).read.toutf8
        rescue
          puts "ノコギリエラー"
          return
        end
        Nokogiri.HTML(html)
      end

      def scrape_urls_name_affiliation nokogiri
        items = nokogiri.xpath(@site[:parent_reg_pattern])
        items.each do |item|
          @name = to_str(item.xpath(@site[:name_reg_pattern]))
          next if @name.blank?
          @url = @site[:host_url] + to_str(item.xpath(@site[:url_reg_pattern]))
          next if Judge.find_by(url: @url)
          @affiliation = format_text(to_str(item.xpath(@site[:affiliation_reg_pattern])))
          scrape_text @url
          save_content
        end
      end

      def scrape_text url
        child_page = get_nokogiri_doc url
        begin
          text = child_page.xpath(@site[:child_reg_pattern]).to_s
          @text = format_text(text)
        rescue
          puts 'scrape_contentsエラー'
          return
        end
      end

      def format_text text
        f_text = text
        f_text.gsub! '家地裁', '家庭裁判所・地方裁判所'
        f_text.gsub! '地家裁', '家庭裁判所・地方裁判所'
        f_text.gsub! '地・家裁', '家庭裁判所・地方裁判所'
        f_text.gsub! '家・地裁', '家庭裁判所・地方裁判所'
        f_text.gsub! '家裁', '家庭裁判所'
        f_text.gsub! '地裁', '地方裁判所'
        f_text.gsub! '簡裁', '簡易裁判所'
        f_text.gsub! '高裁', '高等裁判所'
        f_text.gsub! '最高裁', '最高裁判所'
        f_text.gsub! 'H.', '平成'
        f_text.gsub! 'S.', '昭和'
        f_text.gsub! %r( ), '0'
        f_text
      end

      def save_content
        begin
          if @name.present? && Judge.find_by(url: @url).nil?
            pp @name
            pp @affiliation
            pp Judge.create(name: @name, affiliation: @affiliation, text: @text, url: @url)
          else
            return false
          end
          return true
        rescue
          return 'next'
        end
      end

    end

    judge = Crawler.new :judge
    judge.crawling_start
  end
end
