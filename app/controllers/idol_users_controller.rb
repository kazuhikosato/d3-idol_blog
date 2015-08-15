class IdolUsersController < ApplicationController

  def create
    @idol_user = IdolUser.find_or_create_by(idol_id: params[:idol_id], user_id: current_user.id)
    @idol = @idol_user.idol
    @blogs = @idol.blogs
    redirect_to controller: 'idol', action: 'show', id: @idol.id
  end

  def destroy
    @idol_user = IdolUser.find(params[:id])
    @idol = @idol_user.idol
    @blogs = @idol.blogs
    @idol_user.destroy
    redirect_to controller: 'idol', action: 'show', id: @idol.id
  end
end
