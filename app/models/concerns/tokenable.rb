module Tokenable
  extend ActiveSupport::Concern

protected

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while self.class.exists?(column => self[column])
  end

end
