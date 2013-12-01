class CommentsController < ApplicationController
  def create
    @comment = Comment.new comment_params
    if @comment.save
      redirect_to comment.commentable, notice: "COmment added"
    else
      redirect_to root_url
    end
  end

private
  def comment_params
    params.require(:comment).permit(
      :parent_id,
      :commentable_id,
      :commentable_type,
      :body
    )
  end
end