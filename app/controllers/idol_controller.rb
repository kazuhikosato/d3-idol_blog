class IdolController < ApplicationController
  def index
    @idols = Idol.all.order(:kana)
    #@idols = Idol.all
    #@idols = @idols.sort_by{ |idol|
    #  -idol.blogs.count
    #}
  end

  def show
    @idol = Idol.find(params[:id])
    @blogs = Blog.where(idol_id: params[:id]).order(datetime: :desc)
  end

  def akb
    @idols = view_context.get_team_idol 1
    @team = "akb"
    render 'index'
  end

  def ske
    @idols = view_context.get_team_idol 2
    render 'index'
  end

  def nmb
    @idols = view_context.get_team_idol 3
    render 'index'
  end

  def hkt
    @idols = view_context.get_team_idol 4
    render 'index'
  end

  def nogizaka
    @idols = view_context.get_team_idol 11
    render 'index'
  end

  def og
    @idols = view_context.get_team_idol 12
    render 'index'
  end

end