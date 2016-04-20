$ = require('jquery')

class Flash
  constructor: ->
    $(document).on('click', '.flash__action', Flash.dismiss)
    $(document).on('swiperight', '.flash', Flash.dismiss)
    Flash.show()

  @draw: (message, action) ->
    $message = $('<div />').addClass('flash__message').html(message)
    $flash = $('<div />').addClass('flash')
    $flash.append($(action)) if action
    $flash.append($message).prependTo('body')
    @show()

  @show: =>
    $flash = $('.flash')
    if $flash.length
      $flash.prependTo('body')
      setTimeout(->
        $flash.addClass('flash--is-active')
      , 0)
      setTimeout(@dismiss, 3000)

  @dismiss: =>
    $('.flash').removeClass('flash--is-active')
    setTimeout(@remove, 250)

  @remove: ->
    $('.flash').remove()

module.exports = Flash
