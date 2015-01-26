class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_super_admin!
  before_action :reveal_user, only: [:update]

  def index
    @users = User.where.not(id: 1).order(:is_admin).paginate(page: params[:page])
  end

  def update
    @user.update(params.require(:user).permit(:is_admin))
    redirect_back_or action: :index
  end

  private
  def reveal_user
    @user = User.find params[:id]
  end

end
