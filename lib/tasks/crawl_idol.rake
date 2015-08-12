$:.unshift File.dirname(__FILE__)
require 'idol.rb'

namespace :crawl_akb do

  desc "AKBに関する情報をクローリングして取得"
  task :crawl_start => :environment do


    class AKB < Idols
      def initialize
        @site = {
          host_url:                 'https://48pedia.org',
          base_url:                 'https://48pedia.org/AKB48%E3%83%A1%E3%83%B3%E3%83%90%E3%83%BC%E4%B8%80%E8%A6%A7',
          parent_reg_pattern:       '//*[@id="mw-content-text"]/table[1]/tr',
          team_reg_pattern:         'td[1]/text()',
          name_reg_pattern:         'td[4]/ruby/rb/a/text()',
          kana_reg_pattern:         'td[4]/ruby/rt/text()',
          image_parent_reg_pattern: 'td[3]/a/@href',
          birthday_reg_pattern:     'td[6]/span[1]/@data-sort-value',
          birthplace_reg_pattern:   'td[7]/span/text()',
          url_reg_pattern:          'td[4]/ruby/rb/a/@href',
          child_reg_pattern:        '//*[@id="file"]',
          image_child_pattern:      'a/@href'
        }
      end
    end

    class SKE < Idols
      def initialize
        @site = {
          host_url:                 'https://48pedia.org',
          base_url:                 'http://48pedia.org/SKE48%E3%83%A1%E3%83%B3%E3%83%90%E3%83%BC%E4%B8%80%E8%A6%A7',
          parent_reg_pattern:       '//*[@id="mw-content-text"]/table[1]/tr',
          team_reg_pattern:         'td[1]/text()',
          name_reg_pattern:         'td[3]/ruby/rb/a/text()',
          kana_reg_pattern:         'td[3]/ruby/rt/text()',
          image_parent_reg_pattern: 'td[2]/a/@href',
          birthday_reg_pattern:     'td[5]/span[1]/@data-sort-value',
          birthplace_reg_pattern:   'td[6]/span/text()',
          url_reg_pattern:          'td[3]/ruby/rb/a/@href',
          child_reg_pattern:        '//*[@id="file"]',
          image_child_pattern:      'a/@href'
        }
      end
    end

    class NMB < Idols
      def initialize
        @site = {
          host_url:                 'https://48pedia.org',
          base_url:                 'http://48pedia.org/NMB48%E3%83%A1%E3%83%B3%E3%83%90%E3%83%BC%E4%B8%80%E8%A6%A7',
          parent_reg_pattern:       '//*[@id="mw-content-text"]/table[1]/tr',
          team_reg_pattern:         'td[1]/text()',
          name_reg_pattern:         'td[3]/ruby/rb/a/text()',
          kana_reg_pattern:         'td[3]/ruby/rt/text()',
          image_parent_reg_pattern: 'td[2]/a/@href',
          birthday_reg_pattern:     'td[5]/span[1]/@data-sort-value',
          birthplace_reg_pattern:   'td[6]/span/text()',
          url_reg_pattern:          'td[3]/ruby/rb/a/@href',
          child_reg_pattern:        '//*[@id="file"]',
          image_child_pattern:      'a/@href'
        }
      end
    end

    class HKT < Idols
      def initialize
        @site = {
          host_url:                 'https://48pedia.org',
          base_url:                 'http://48pedia.org/HKT48%E3%83%A1%E3%83%B3%E3%83%90%E3%83%BC%E4%B8%80%E8%A6%A7',
          parent_reg_pattern:       '//*[@id="mw-content-text"]/table[1]/tr',
          team_reg_pattern:         'td[1]/text()',
          name_reg_pattern:         'td[3]/ruby/rb/a/text()',
          kana_reg_pattern:         'td[3]/ruby/rt/text()',
          image_parent_reg_pattern: 'td[2]/a/@href',
          birthday_reg_pattern:     'td[5]/span[1]/@data-sort-value',
          birthplace_reg_pattern:   'td[6]/span/text()',
          url_reg_pattern:          'td[3]/ruby/rb/a/@href',
          child_reg_pattern:        '//*[@id="file"]',
          image_child_pattern:      'a/@href'
        }
      end
    end

    class Nogizaka < Idols
      def initialize
        @site = {
          host_url:                 'https://48pedia.org',
          base_url:                 'http://48pedia.org/%E4%B9%83%E6%9C%A8%E5%9D%8246%E3%83%A1%E3%83%B3%E3%83%90%E3%83%BC%E4%B8%80%E8%A6%A7',
          parent_reg_pattern:       '//*[@id="mw-content-text"]/table[1]/tr',
          team_reg_pattern:         'td[1]/text()',
          name_reg_pattern:         'td[3]/ruby/rb/a/text()',
          kana_reg_pattern:         'td[3]/ruby/rt/text()',
          image_parent_reg_pattern: 'td[2]/a/@href',
          birthday_reg_pattern:     'td[5]/span[1]/@data-sort-value',
          birthplace_reg_pattern:   'td[6]/span/text()',
          url_reg_pattern:          'td[3]/ruby/rb/a/@href',
          child_reg_pattern:        '//*[@id="file"]',
          image_child_pattern:      'a/@href'
        }
      end
    end
    class OB < Idols
      def initialize
        @site = {
          host_url:                 'https://48pedia.org',
          base_url:                 'http://48pedia.org/AKB48%E5%85%83%E3%83%A1%E3%83%B3%E3%83%90%E3%83%BC%E4%B8%80%E8%A6%A7',
          parent_reg_pattern:       '//*[@id="mw-content-text"]/table[1]/tr',
          team_reg_pattern:         'td[1]/text()',
          name_reg_pattern:         'td[3]/ruby/rb/a/text()',
          kana_reg_pattern:         'td[3]/ruby/rt/text()',
          image_parent_reg_pattern: 'td[2]/a/@href',
          birthday_reg_pattern:     'td[5]/span[1]/@data-sort-value',
          birthplace_reg_pattern:   'td[6]/span/text()',
          url_reg_pattern:          'td[3]/ruby/rb/a/@href',
          child_reg_pattern:        '//*[@id="file"]',
          image_child_pattern:      'a/@href'
        }
      end

      def scrape_child_contents item
        @teams = ["OG"]
        if %r(index.php?) =~ @url
          @url = nil
          return
        end
        if %r(/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB:AKB48Profile2013_nobody.jpg) =~ @image_url
          @image_url = nil
          return
        end
        super
      end

    end
    idols =[HKT.new]
    idols.each do |idol|
      idol.crawl_start
    end
  end
end
