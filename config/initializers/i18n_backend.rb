class TestExceptionLocalizationHandler
  def call(exception, locale, key, options)
    default = key.split('.').pop().humanize.capitalize
    I18n.backend.store_translations(I18n.default_locale, {key => default}, :escape => false)
    default
    # raise exception.message
  end
end

I18n.exception_handler = TestExceptionLocalizationHandler.new
I18n.backend = I18n::Backend::KeyValue.new(Redis.new)
