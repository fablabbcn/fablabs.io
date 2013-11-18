class DiscussionsController < ApplicationController

  before_filter :load_discussable

  def new
    @discussion = @discussable.discussions.new
  end

  def create
    @discussion = @discussable.discussions.build discussion_params
    @discussion.creator = current_user
    if @discussion.save
      redirect_to @discussable, notice: "Discussion Created"
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

  def load_discussable
    resource, id = request.path.split('/')[1, 2]
    @discussable = resource.singularize.classify.constantize.find(id)
  end

end
