class Machine < Thing

  def to_param
    slug
  end

  private
end
