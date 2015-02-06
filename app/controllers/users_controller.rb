class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_super_admin!, except: [ :mention_query ]
  before_action :reveal_user, only: [:update]

  def mention_query
    if params[:keyword].blank?
      render json: []
      return
    end
    users = User.where("nickname LIKE ?", "#{params[:keyword]}%").limit(7).map do |user|
      "#{user.nickname}(#{user.id})"
    end
    render json: users
  end

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
