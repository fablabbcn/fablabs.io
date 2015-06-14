//= require masonry.pkgd.min.js
//= require trianglify.min.js

formatRes = (res) ->
  if res.loading
    return res
  markup = '<img alt="' + res.username + '" class="avatar tiny" src="' + res.avatar + '">' + '&nbsp;&nbsp;&nbsp;' + res.username
  markup


formatResSelection = (res) ->
  '<img alt="' + res.username + '" class="avatar tiny" src="' + res.avatar + '">' + '&nbsp;&nbsp;&nbsp;' + res.username

triglify = (h, w) ->
  size = Math.floor Math.random() * 99 + 1
  pattern = Trianglify(
      height: h,
      width: w,
      cell_size: size,
      x_colors: 'random'
    )
  image = 'url(' + pattern.png() + ')'

  return image


$(window).load ->
  if ($('#project-container'))
    $('#project-container').masonry itemSelector: '#project-container li'

  if $('#project-container li .project').length > 0
    $('#project-container li .project').each ->
      image = triglify(150, 350)
      $(this).children('.project-title').css('background-image', image)

  if $('.main-project')
    image = triglify(300, 1200)
    $('.main-project').css('background-image', image)

  $('#contributions_attributes').select2
    placeholder: "Select a user",
    allowClear: true
    ajax:
      url: 'http://api.fablabs.io/v0/users'
      dataType: 'json'
      delay: 250
      data: (params) ->
        {
          username: params.term
        }
      processResults: (data) ->
        # parse the results into the format expected by Select2.
        # since we are using custom formatting functions we do not need to
        # alter the remote JSON data
        { results: data.users }
      cache: true
    escapeMarkup: (markup) ->
      markup
    minimumInputLength: 1
    templateResult: formatRes
    templateSelection: formatResSelection

  return
