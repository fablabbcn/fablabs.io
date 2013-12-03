class Machine < Thing
  def to_param
    "#{id}-#{brand}-#{name}".parameterize
  end
end
