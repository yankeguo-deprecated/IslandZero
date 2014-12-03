class StarredTopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    @starred_topics = current_user.starred_topics.paginate(:page => params[:page])
  end

  def create
    topic = Topic.find_by_id(params[:id])
    if topic
      TopicUser.find_or_create_by(topic: topic, user: current_user)
      .update(is_starred: true)

      if request.xhr?
        render nothing: true
      else
        redirect_to :back
      end
    else
      render plain: 'Topic not found'
    end
  end

  def destroy
    topic = Topic.find_by_id(params[:id])
    TopicUser.where(topic: topic, user: current_user).update_all(is_starred: false)

    if request.xhr?
      render nothing: true
    else
      redirect_to :back
    end
  end

end
