class DiscussionsController < ApplicationController

  before_filter :load_discussable

  def new
    @discussion = @discussable.discussions.new
    authorize_action_for @discussion
  end

  def create
    @discussion = @discussable.discussions.build discussion_params
    @discussion.creator = current_user
    authorize_action_for @discussion
    if @discussion.save
      redirect_to @discussable, notice: "Discussion Created"
    else
      render :new
    end
  end

  def show
    @discussion = Discussion.find(params[:id])
    authorize_action_for @discussion
    @comment = @discussion.comments.build
  end

private

  def discussion_params
    params.require(:discussion).permit(
      :title,
      :body,
      :discussable_id,
      :discussable_type
    )
  end

  def load_discussable
    resource, id = request.path.split('/')[1, 2]
    @discussable = resource.singularize.classify.constantize.find(id)
  end

end
