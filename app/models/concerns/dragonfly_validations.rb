module DragonflyValidations

  def dragonfly_validations(method)
    validates_size_of method, maximum: 5.megabytes,
      message: "should be no more than 5 MB", if: "#{method}_changed?".to_sym

    validates_property :format, of: method, in: [:jpeg, :jpg, :png], case_sensitive: false,
      message: "should be either .jpeg, .jpg, .png", if: "#{method}_changed?".to_sym
  end
end
