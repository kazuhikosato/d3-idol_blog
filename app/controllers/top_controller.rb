class TopController < ApplicationController
  before_action :authenticate_user!, only: :favorite

  def index
    if user_signed_in?
      idols = view_context.get_favorite_idol current_user
      blog_array = []
      idols.each do |idol|
        puts idol
        blog_array.concat idol.blogs unless idol.blogs.blank?
      end
      @blogs = blog_array.sort{ |a, b|
        b[:datetime] <=> a[:datetime]
      }[0..100]
      @blogs_login = @blogs
    else
      @blogs = Blog.all.order(datetime: :desc).limit(100)
      @blogs_login = @blogs
    end
  end

  def all
    @blogs = Blog.all.order(datetime: :desc).limit(100)
    @blogs_login = @blogs
    render 'index'
  end

  def akb
    @blogs = view_context.get_team_blog(1)[0...100]
    @blogs_login = @blogs
    render 'index'
  end

  def ske
    @blogs = view_context.get_team_blog(2)[0...100]
    @blogs_login = @blogs
    render 'index'
  end

  def nmb
    @blogs = view_context.get_team_blog(3)[0...100]
    @blogs_login = @blogs
    render 'index'
  end

  def hkt
    @blogs = view_context.get_team_blog(4)[0...100]
    @blogs_login = @blogs
    render 'index'
  end

  def nogizaka
    @blogs = view_context.get_team_blog(11)[0...100]
    @blogs_login = @blogs
    render 'index'
  end

  def og
    @blogs = view_context.get_team_blog(12)[0...100]
    @blogs_login = @blogs
    render 'index'
  end
end
