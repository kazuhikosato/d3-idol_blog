class TopController < ApplicationController

  def index
    @blogs = Blog.all.order(datetime: :desc).limit(100)
  end

  def akb
    @blogs = view_context.get_team_blog 1
    render 'index'
  end

  def ske
    @blogs = view_context.get_team_blog 2
    render 'index'
  end

  def nmb
    @blogs = view_context.get_team_blog 3
    render 'index'
  end

  def hkt
    @blogs = view_context.get_team_blog 4
    render 'index'
  end

  def nogizaka
    @blogs = view_context.get_team_blog 11
    render 'index'
  end

  def og
    @blogs = view_context.get_team_blog 12
    render 'index'
  end
end
