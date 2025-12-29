class NoEmailsOrLinksValidator < ActiveModel::Validator
  EMAIL_REGEX = /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b/
  LINK_REGEX = /\b(?:https?:\/\/|www\.|ftp:\/\/)\S+\b/

  def validate(record)
    attributes.each do |attribute|
      value = record.send(attribute)
      if value.present? && (value.match?(EMAIL_REGEX) || value.match?(LINK_REGEX))
        record.errors.add(attribute, "cannot contain emails or links.")
      end
    end
  end

  private

  def attributes
    Array(options[:attributes]) # Convert single attribute to array for uniform handling
  end
end