//= require masonry.pkgd.min.js
//= require trianglify.min.js

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

  return
