class CommentsController < ApplicationController
  def show
    #@post = Post.find(params[:post_id])
    #@comment = @post.comments.find(params[:id])
    @comment = Comment.find(params[:id])
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    #@comment.user_id = @post.user_id
    if @comment.save
      redirect_to post_path(@post)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @post = @comment.post

    if @comment.update(comment_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    redirect_to post_path(@post), status: :see_other
  end

  private
    def comment_params
      params.require(:comment).permit(:title, :body, :post_id, :user_id)
    end
end
