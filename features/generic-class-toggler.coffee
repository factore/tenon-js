

class GenericClassToggler
  constructor: ->
    $(document).on('click', '[data-toggler-selector]', @_toggle)

  _toggle: (e) ->
    e.preventDefault()
    $toggler = $(e.currentTarget)
    $target = $($toggler.data('toggler-selector'))
    className = $toggler.data('toggler-class')

    $target.toggleClass(className)
    $target.trigger('classToggled', [className])

module.exports = GenericClassToggler
