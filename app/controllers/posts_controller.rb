class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(comments: [:author]).where(posts: { author_id: @user.id })
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    new_post = current_user.posts.new(post_params)
    new_post.likes_counter = 0
    new_post.comments_counter = 0

    respond_to do |format|
      format.html do
        if new_post.save
          redirect_to "/users/#{new_post.author_id}/posts/", notice: 'Post was successfully created.'
        else
          render :new, status: 'Error occured will creating post!'
        end
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.author.decrement!(:posts_counter)
    Post.delete(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
