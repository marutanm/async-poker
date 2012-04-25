$(document).ready ->
  $('#to_vote .card').click ->
    $.post '/',
      story_id: $(@).parent().attr('id')
      value: $(@).children('.value').text()
      =>
        $(@).parent().children('.selected').removeClass('selected')
        $(@).addClass('selected')

  $('.story-list tr').click ->
    console.log $(@).attr('id')
    $.pjax
      url: "/story/#{$(@).attr('id')}"
      container: '.container'
