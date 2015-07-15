class DocumentsController < ApplicationController

  def destroy
    @document = Document.find(params[:id])
    @project = @document.project
    if authorize_action_for @project
      @document.delete
      redirect_to edit_project_path(@project), notice: "Document deleted"
    else
      redirect_to project_path(@project), notice: "You cannot delete this document"
    end
  end

  private

    def document_params
      params.require(:document).permit(:image, :title, :description)
    end

end
