$(document).ready ->
  $('#to_vote .card').click ->
    $.post '/',
      story_id: $(@).parent().attr('id')
      value: $(@).children('.value').text()
      =>
        $(@).parent().children('.selected').removeClass('selected')
        $(@).addClass('selected')
