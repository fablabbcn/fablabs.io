# class TestExceptionLocalizationHandler
#   def call(exception, locale, key, options)
#     if key =~ /activerecord.errors/

#     else
#       default = key.to_s.split('.').pop().humanize.capitalize
#       I18n.backend.store_translations(I18n.default_locale, {key => default}, :escape => false)
#       default
#     end
#     # raise exception.message
#   end
# end

# I18n.exception_handler = TestExceptionLocalizationHandler.new

TRANSLATION_STORE = Redis.new
I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new(TRANSLATION_STORE), I18n.backend)

