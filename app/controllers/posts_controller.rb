class PostsController < ApplicationController

  if IslandZero.open_to_public
    before_action :authenticate_user!, except: [:show]
  else
    before_action :authenticate_user!
  end

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_permission, only: [:edit, :update, :destroy]

  respond_to :html

  def show
    # Jump if not a top_post
    if @post.parent_post.present?
      redirect_to post_path(@post.parent_post, jump_sub_post: @post.id)
      return
    end

    # Jump if specified
    if params[:jump_sub_post].present?
      sid = params[:jump_sub_post].to_i
      sub_post = Post.find_by_id sid
      if sub_post.present?
        pos = @post.sub_posts.where("id <= ?", sub_post.id).count
        page= (pos.to_f / WillPaginate.per_page.to_f).ceil
        redirect_to post_path(@post, page: page, anchor: "sub_post_#{sid}")
        return
      end
    end

    # Prepare a Message
    @chattable = @post
    if user_signed_in?
      @new_message = Message.new(chattable: @chattable)
    end

    # Prepare a sub-post
    if user_signed_in?
      @new_post = Post.new(topic: @post.topic, parent_post: @post)
    end

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
    .clean_basic(:content)
    .clean_strict(:title)

    if post_params[:content].blank? and post_params[:title].blank?
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

    @post = current_user.posts.create(post_params)

    if request.xhr?
      render nothing: true
    else
      flash.notice = "Post created."
      redirect_to :back
    end
  end

  def update
    post_params = params.require(:post)
    .permit(:content, :title)
    .clean_basic(:content)
    .clean_strict(:title)
    @post.update(post_params)
    if request.xhr?
      render nothing: true
    else
      if @post.parent_id == 0
        redirect_to post_path(@post)
      else
        redirect_to post_path(@post.parent_post)
      end
    end
  end

  def destroy
    @post.destroy
    if @post.parent_id == 0
      redirect_to topic_path(@post.topic)
    else
      redirect_to :back
    end
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def check_permission
    unless current_user.is_admin || current_user == @post.user
      flash.alert = t(:you_are_not_admin)
      redirect_to topic_path(@post.topic)
    end
  end

end
