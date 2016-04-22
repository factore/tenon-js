

class NavItemToggle
  constructor: ->
    $('.main-nav__link-toggle')
      .on('click', @_toggle)

  _toggle: (e) ->
    e.preventDefault()
    $(e.currentTarget).closest('.main-nav__item')
      .toggleClass('main-nav__item--open')

module.exports = NavItemToggle
