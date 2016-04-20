$ = require('jquery')
imagesLoaded = require('imagesloaded')
_ = require('lodash')

class Aesthetics
  constructor: (@$container) ->
    @$wrap = @$container.closest('.tn-tc__wrap')
    imagesLoaded(@$container, @_applyAesthetics)
    $(window).on('resize', @_applyAesthetics)
    $(document).on('cocoon:after-insert', '.tn-tc__rows', @_applyAesthetics)
    @$container.on('tenon.asset_attached', '.tn-tc-asset-field', @_applyAesthetics)
    @$container.on('tenon.content.column_resized', 'div', @_applyAesthetics)
    @$wrap.on('tenon.content.popped', @_applyAesthetics)
    @$wrap.on('tenon.content.resized', @_applyAesthetics)
    @$container.on('keyup', '.editable-text', _.debounce(@_applyAesthetics, 350))

  _applyAesthetics: =>
    if @$wrap.hasClass('mobile-breakpoint')
      @$container.find('.editable-text').css('min-height', '')
    else
      @_setMinimumEditorHeightWithImage()
      @_setMinimumWrappedEditorHeight()

  _setMinimumEditorHeightWithImage: =>
    $.each @$container.find('.tn-tc-image-and-text, .tn-tc-multi-text'), (i, row) ->
      $images = $(row).find('.image, .editable-text')
      $images.css('min-height', '0px')
      heights = $.map($images, (img, i) -> $(img).outerHeight())
      height = Math.max.apply(Math, heights)
      $(row).find('.editable-text').css('min-height', height)

  _setMinimumWrappedEditorHeight: =>
    $.each @$container.find('.tn-tc__wrapped-image-with-text'), (i, row) ->
      height = $(row).find('.image').height();
      $(row).find('.editable-text').css('min-height', height + 20)

module.exports = Aesthetics
