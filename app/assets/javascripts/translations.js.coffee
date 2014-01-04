jQuery ->
  $('table.translations textarea').change ->
    $(this).parents('form').submit()

  $('#locale-select').change ->
    window.location = "/translations?translation_locale=#{$(this).val()}"