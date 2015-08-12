$:.unshift File.dirname(__FILE__)
require 'crawler.rb'

namespace :crawl_prefectures do

  desc "都道府県をクローリングして取得"
  task :crawl_start => :environment do


    class Place < Crawler
      attr_accessor :place
      def initialize
        @site = {
          base_url:                 'http://www.hukumusume.com/jap/index.html',
          parent_reg_pattern:       '/html/body/table//tr/td/table[2]/tr/td[2]/table/tr[2]/td/a',
          place_reg_pattern:        'text()',
        }
      end

      def scrape_parent_contents item
        @place = scrape_item(item, @site[:place_reg_pattern])
        save_content
      end

      def save_content
        Birthplace.create(name: @place)
      end
    end

    place = Place.new
    place.crawl_start
  end
end
