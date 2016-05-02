

class ModalWindows
  @closeModals: ->
    @clearBody()
    $.each $('.modal:not([data-react-provided])'), (i, el) ->
      $el = $(el)
      $el.removeClass('modal--is-active')
      if $el.data('modal-remove-on-close')
        setTimeout((-> $el.remove()), 250)


  @clearBody: ->
    $('.modal-overlay:not([data-react-provided])').removeClass('modal-overlay--is-active')
    $('body').css(overflow: '')

  @prepBodyForModal: ->
    $overlay = $('<div class="modal-overlay" />')
    $overlay.appendTo('body') unless $('.modal-overlay--is-active').length
    $('body').css(overflow: 'hidden')
    setTimeout( ->
      $overlay.addClass('modal-overlay--is-active')
    , 0
    )

  constructor: ->
    tags = [
      '[data-modal-target]',
      '[data-modal-remote]',
      '[data-model-content]',
      '[data-keyboard]'
    ]
    $(document).off('click.tn:modal-on', tags.join(', '))
    $(document).off('click.tn:modal-on', '.modal-overlay, [data-modal-close]')
    $(document).on('click.tn:modal-on', tags.join(', '), @launchFromLink)
    $(document).on('click.tn:modal-off', '.modal-overlay, [data-modal-close]', @closeModals)
    $('body').on('keyup', (e) => @closeModals() if e.which == 27)
  # Opts:
  #   $link: if launched by data tags, the link that was clicked
  #   title: string -- Title for the modal window
  #   remote: bool -- launch via a URL?
  #   href: string -- remote URL to launch
  #   target: string -- selector for the HTML element
  #   parent: string -- selector to use for parent of target
  #   handler: string -- string version of the class to instantiate on opening
  #   closest: string -- selector for link's parent when finding target
  #   clone: bool -- clone the target before putting it in the modal?
  #   content: string -- content to output directly in the modal
  #   keyboard: boolean -- legacy, not sure what it does
  launchWithOpts: (@opts = {}) =>
    @_chooseStrategy()

  launchFromLink: (e) =>
    e.preventDefault()
    $link = $(e.currentTarget)
    @opts =
      $link: $link
      href: $link.attr('href')
      title: $link.data('modal-title')
      remote: $link.data('modal-remote')
      target: $link.data('modal-target')
      handler: $link.data('modal-handler')
      closest: $link.data('modal-closest')
      parent: $link.data('modal-parent')
      clone: $link.data('modal-clone')
      content: $link.data('modal-content')
      keyboard: $link.data('keyboard')
    @_chooseStrategy()

  closeModals: ->
    ModalWindows.closeModals()

  _chooseStrategy: =>
    @_launchWithUrl() if @opts.remote
    @_launchWithTarget() if @opts.target?.length
    @_launchWithContent() if @opts.content?.length

  _launchWithUrl: (e) =>
    @remote = true
    $.ajax
      url: @opts.href
      dataType: 'html'
      success: @_openInModal
      beforeSend: null

  _launchWithContent: =>
    @_openInModal(@opts.content)

  _launchWithTarget: (e) =>
    if @opts.closest?.length && @opts.$link
      $parentNode = @opts.$link.closest(@opts.closest)
      $el = $parentNode.find(@opts.target)
    else if @opts.parent?.length
      $el = $(@opts.parent).find(@opts.target)
    else
      $el = $(@opts.target)
    $el = $el.filter(':first').clone() if @opts.clone
    @_openInModal($el)

  _openInModal: (el) =>
    @$modalElement = $(el)
    @_drawAndDisplayModal()
    @_runShownHandler()

  _drawAndDisplayModal: =>
    if @remote
      @$modalElement.data('modal-remove-on-close', true)
    @$modalElement.appendTo('body')
    ModalWindows.prepBodyForModal()
    setTimeout( =>
      @$modalElement.addClass('modal--is-active')
    , 0)

  _runShownHandler: =>
    if @opts.handler?.length
      new Tenon.modalHandlers[@opts.handler](
        @opts.$link,
        @$modalElement,
        @$modalElement
      )

    # Default shown action
    @_focusFirstField()

  _focusFirstField: ->
    selectors = [
      ".modal-content form input[type!='hidden']",
      ".modal-content form select",
      ".modal-content form textarea"
    ]
    el = $(selectors.join(', '))[0]
    $(el).focus()

module.exports = ModalWindows
