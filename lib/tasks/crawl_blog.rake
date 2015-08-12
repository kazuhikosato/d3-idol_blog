$:.unshift File.dirname(__FILE__)
require 'blog.rb'

namespace :crawl_blog do

  desc "AKBのブログ情報をクローリングして取得"
  task :crawl_start => :environment do


    class Akb < Blogs
      def initialize
        @site = {
          host_url:                 'http://www.akiba48.net',
          base_url:                 'http://www.akiba48.net/akb48/',
          parent_reg_pattern:       '//*[@id="articleNews"]/div[2]/div[1]/div/div',
          title_reg_pattern:        'div/div[4]/a/text()',
          name_reg_pattern:         'div/div[3]/text()',
          url_reg_pattern:          'div/div[4]/a/@href',
          datetime_reg_pattern:     'div/div[1]/text()',
        }
      end
    end

    class Ske < Blogs
      def initialize
        @site = {
          host_url:                 'http://www.akiba48.net',
          base_url:                 'http://www.akiba48.net/ske48/',
          parent_reg_pattern:       '//*[@id="articleNews"]/div[2]/div[1]/div/div',
          title_reg_pattern:        'div/div[4]/a/text()',
          name_reg_pattern:         'div/div[3]/text()',
          url_reg_pattern:          'div/div[4]/a/@href',
          datetime_reg_pattern:     'div/div[1]/text()',
        }
      end
    end

    class Nmb < Blogs
      def initialize
        @site = {
          host_url:                 'http://www.akiba48.net',
          base_url:                 'http://www.akiba48.net/nmb48/',
          parent_reg_pattern:       '//*[@id="articleNews"]/div[2]/div[1]/div',
          title_reg_pattern:        'div/div[4]/a/text()',
          name_reg_pattern:         'div/div[3]/text()',
          url_reg_pattern:          'div/div[4]/a/@href',
          datetime_reg_pattern:     'div/div[1]/text()',
        }
      end
    end
    class Hkt < Blogs
      def initialize
        @site = {
          host_url:                 'http://www.akiba48.net',
          base_url:                 'http://www.akiba48.net/hkt48/',
          parent_reg_pattern:       '//*[@id="articleNews"]/div[2]/div[1]/div',
          title_reg_pattern:        'div/div[4]/a/text()',
          name_reg_pattern:         'div/div[3]/text()',
          url_reg_pattern:          'div/div[4]/a/@href',
          datetime_reg_pattern:     'div/div[1]/text()',
        }
      end
    end

    class Og < Blogs
      def initialize
        @site = {
          host_url:                 'http://www.akiba48.net',
          base_url:                 'http://www.akiba48.net/og/',
          parent_reg_pattern:       '//*[@id="articleNews"]/div[2]/div[1]/div',
          title_reg_pattern:        'div/div[4]/a/text()',
          name_reg_pattern:         'div/div[3]/text()',
          url_reg_pattern:          'div/div[4]/a/@href',
          datetime_reg_pattern:     'div/div[1]/text()',
        }
      end
    end

    class Nogi < Blogs
      def initialize
        @site = {
          host_url:                 '',
          base_url:                 'http://blog.nogizaka46.com/atom.xml',
          parent_reg_pattern:       '//entry',
          title_reg_pattern:        'title/text()',
          name_reg_pattern:         'author/name/text()',
          url_reg_pattern:          'link/@href',
          datetime_reg_pattern:     'published/text()',
        }
      end
      def get_idol_id item
        if %r(研究生) === item
          item = "乃木坂#{item}"
        end
        super
      end
    end

    idols =[Akb.new, Ske.new, Nmb.new, Hkt.new, Og.new, Nogi.new]
    idols.each do |idol|
      idol.crawl_start
    end
  end
end
