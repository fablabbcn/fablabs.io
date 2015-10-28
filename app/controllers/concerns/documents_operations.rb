module DocumentsOperations

  extend ActiveSupport::Concern

  def edit_object_path(object, type)
    case type
    when "Project"
      edit_project_path object
    when "Thing"
      edit_thing_path object
    end
  end

  def object_path(object, type)
    case type
    when "Project"
      project_path object
    when "Thing"
      thing_path object
    end
  end
end
