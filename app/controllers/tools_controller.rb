class ToolsController < ApplicationController

  def index
    @tools = Tool.all
  end

  def show
    @tool = Tool.find(params[:id])
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save
      redirect_to tool_url(@tool), notice: "Tool Created"
    else
      render :new
    end
  end

  def edit
    @tool = Tool.find(params[:id])
  end

  def update
    @tool = Tool.find(params[:id])
    if @tool.update_attributes tool_params
      redirect_to tool_url(@tool), notice: "Tool Updated"
    else
      render :edit
    end
  end

  def edit
    @tool = Tool.find(params[:id])
  end

private

  def tool_params
    params.require(:tool).permit!
  end

end
