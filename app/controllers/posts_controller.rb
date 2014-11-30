class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    params[:parent_id] = 0 if params[:parent_id].nil?
    @posts = Post.where(params.permit(:parent_id, :topic_id))
    respond_with(@posts)
  end

  def show
    # Prepare a Message
    @chattable = @post
    @new_message = Message.new
    @new_message.chattable = @chattable

    # Prepare a sub-post
    @new_post = Post.new
    @new_post.topic = @post.topic
    @new_post.parent_post = @post

    # Reveal sub-posts
    @sub_posts = @post.sub_posts.order("id DESC").paginate(:page => params[:page])

    # Reveal Topic
    @topic = @post.topic

    respond_with(@post)
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def edit
  end

  def create
    post_params = params.require(:post)
    .permit(:content, :topic_id, :parent_id, :title)
    .clean(:content, :title)

    if post_params[:content].blank?
      redirect_to :back, flash: { alert: 'Content Missing' }
      return
    end

    if post_params[:topic_id].blank? and post_params[:parent_id].blank?
      redirect_to :back, flash: { alert: 'Params Missing' }
      return
    end

    if post_params[:parent_id].present?
      parent = Post.find_by_id post_params[:parent_id]
      if parent.nil?
        redirect_to :back, flash: { alert: 'Parent Post Not Found' }
        return
      else
        post_params[:topic_id] = parent.topic_id
      end
    end

    @post = current_user.posts.new(post_params)
    @post.save
    if request.xhr?
      render nothing: true
    else
      flash.notice = "Post created."
      redirect_to :back
    end
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

end
