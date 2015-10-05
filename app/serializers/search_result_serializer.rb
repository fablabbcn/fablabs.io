class SearchResultSerializer < ActiveModel::Serializer
  # cached
  attributes :id,
  :url,
  :title


  def title
    if object.title
      return object.title
    elsif object.name
      return object.name
    else return " "
    end
  end
end
