class LocalCountry < Country
  def name
    translations[I18n.locale.to_s] || names.first
  end
end
