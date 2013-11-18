class DiscussionsController < ApplicationController

  def index
    @discussions = Lab.friendly.find(params[:lab_id]).discussions
  end

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = current_user.discussions.build discussion_params
    if @discussion.save
      redirect_to polymorphic_url([@discussion.discussable, @discussion]), notice: "Discussion Created"
    else
      render :new
    end
  end

  def show
    @discussion = Discussion.find(params[:id])
    @comment = @discussion.comments.build
  end

private

  def discussion_params
    params.require(:discussion).permit!
  end

end
