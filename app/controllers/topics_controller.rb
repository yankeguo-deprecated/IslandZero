class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    params[:parent_id] = 0 unless params[:parent_id].present?
    @topics = Topic.where(params.permit(:parent_id))
    respond_with(@topics)
  end

  def show
    respond_with(@topic)
  end

  def new
    @topic = Topic.new
    respond_with(@topic)
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.save
    respond_with(@topic)
  end

  def update
    @topic.update(topic_params)
    respond_with(@topic)
  end

  def destroy
    @topic.destroy
    respond_with(@topic)
  end

  private
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:title, :introduction)
    end
end
