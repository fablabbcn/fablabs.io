class SearchResultSerializer < ActiveModel::Serializer
  # cached
  :id,
  :url,
  :title


  def title
    if object.has_key? title
      return object.title
    elsif object.has_key? name
      return object.name
    else return " "
    end
  end
end
