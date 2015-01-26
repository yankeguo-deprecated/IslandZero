class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_super_admin!

  def index
    @users = User.all.order(:is_admin).paginate(page: params[:page])
  end

  def update
    @user.update(params.require(:user).permit(:is_admin))
    redirect_back_or action: :index
  end

  private
  def reveal_user
    @user = User.find params[:id]
    redirect_back_or action: :index
  end

end
