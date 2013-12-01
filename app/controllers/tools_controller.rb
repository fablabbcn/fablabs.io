class ToolsController < ApplicationController

  def index
    @tools = Tool.all
    authorize_action_for @tools
  end

  def show
    @tool = Tool.find(params[:id])
    authorize_action_for @tool
  end

  def new
    @tool = Tool.new
    authorize_action_for @tool
  end

  def create
    @tool = Tool.new(tool_params)
    authorize_action_for @tool
    if @tool.save
      redirect_to tool_url(@tool), notice: "Tool Created"
    else
      render :new
    end
  end

  def edit
    @tool = Tool.find(params[:id])
    authorize_action_for @tool
  end

  def update
    @tool = Tool.find(params[:id])
    authorize_action_for @tool
    if @tool.update_attributes tool_params
      redirect_to tool_url(@tool), notice: "Tool Updated"
    else
      render :edit
    end
  end

  def edit
    @tool = Tool.find(params[:id])
    authorize_action_for @tool
  end

private

  def tool_params
    params.require(:tool).permit(
      :name,
      :brand_id,
      :description,
      :parent_id
    )
  end

end
