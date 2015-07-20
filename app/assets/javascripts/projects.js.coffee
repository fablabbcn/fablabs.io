//= require masonry.pkgd.min.js
//= require trianglify.min.js


formatUser = (res) ->
  if res.loading
    return res
  markup = "<img alt='" + res.username + "' class='avatar tiny' src='" + res.avatar + "'>" + "&nbsp;&nbsp;&nbsp;" + res.username
  markup


formatUserSelection = (res) ->
  "<img alt='" + res.username + "' class='avatar tiny' src='" + res.avatar + "'>" + "&nbsp;&nbsp;&nbsp;" + res.username


formatLab = (res) ->
  if res.loading
    return res
  markup = "<img alt='" + res.name + "' class='avatar tiny' src='" + res.avatar + "'>" + "&nbsp;&nbsp;&nbsp;" + res.name
  markup


formatLabSelection = (res) ->
  "<img alt='" + res.name + "' class='avatar tiny' src='" + res.avatar + "'>" + "&nbsp;&nbsp;&nbsp;" + res.name


triglify = (h, w) ->
  size = Math.floor Math.random() * 99 + 1
  pattern = Trianglify(
      height: h,
      width: w,
      cell_size: size,
      x_colors: "random"
    )
  image = "url(" + pattern.png() + ")"

  return image

$(document).foundation clearing: open_selectors: '.image_link'

$(document).foundation orbit:
  animation: 'slide'
  timer_speed: 1000
  pause_on_hover: true
  animation_speed: 500
  navigation_arrows: true
  bullets: false

$(window).load ->

  if $(".radio")
    $(".radio").click ->
      console.log $($($(this).parent()).children()[0]).click()

  if ($("#project_documents_attributes_image")[0])
    val = $("#project_documents_attributes_image")[0].value
    $("#file-input-name").text(val)

    $("#project_documents_attributes_image").on "change", ->
      val = $("#project_documents_attributes_image")[0].value
      $("#file-input-name").text(val)

  if ($("#project-container"))
    $("#project-container").masonry itemSelector: "#project-container li"

  if $("#project-container li .project").length > 0
    $("#project-container li .project").each ->
      if $(this).children(".project-title").css("background-image") == "none"
        image = triglify(150, 350)
        $(this).children(".project-title").css("background-image", image)

  if $("#contributions_attributes")
    $("#contributions_attributes").select2
      placeholder: "Select a user..",
      allowClear: true
      ajax:
        url: "https://api.fablabs.io/v0/users"
        dataType: "json"
        delay: 250
        data: (params) ->
          {
            q: params.term
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
      templateResult: formatUser
      templateSelection: formatUserSelection

    if $("#collaborations_attributes")
      $("#collaborations_attributes").select2
        placeholder: "Select a lab..",
        allowClear: true
        ajax:
          url: "https://api.fablabs.io/v0/labs/search"
          dataType: "json"
          delay: 250
          data: (params) ->
            {
              q: params.term
            }
          processResults: (data) ->
            # parse the results into the format expected by Select2.
            # since we are using custom formatting functions we do not need to
            # alter the remote JSON data
            { results: data.labs }
          cache: true
        escapeMarkup: (markup) ->
          markup
        minimumInputLength: 1
        templateResult: formatLab
        templateSelection: formatLabSelection

  return
