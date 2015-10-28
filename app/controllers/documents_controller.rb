class DocumentsController < ApplicationController
  include DocumentsOperations

  def destroy
    @document = Document.find(params[:id])
    @item = @document.documentable
    @type = @document.documentable_type
    if authorize_action_for @item
      @document.delete
      redirect_to edit_object_path(@item, @type), notice: "Document deleted"
    else
      redirect_to object_path(@item, @type), notice: "You cannot delete this document"
    end
  end

  private

    def document_params
      params.require(:document).permit(:image, :title, :description)
    end

end
