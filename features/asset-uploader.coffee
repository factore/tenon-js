React = require('react');
ReactDOM = require('react-dom');
AssetProgress = require('tenon/components/shared/asset-progress');

class AssetUploader
  constructor: (@doneFunction) ->
    @$progress = $('.progress-container:visible')
    @$list = $('#assets.record-grid')
    @titleCounter = 1
    @_allowEsc()
    $(document).on('click', '.upload', @_blockEsc)
    $(document).on('keyup', @_keyUp)

  initialize: (form) =>
    @$form = $(form)
    @$form.fileupload
      add: @_add
      progress: @_updateProgess
      done: @doneFunction
      fail: @_errorMessage
      stop: @_resetCounter

  _keyUp: (ev) =>
    if (ev.keyCode is 27) && @allowEsc
      $('.modal').removeClass('in')
      $('.modal-backdrop').removeClass('in')
      $('.modal').fadeOut()
      $('.modal-backdrop').fadeOut()
    else
      @_allowEsc()

  _blockEsc: =>
    @allowEsc = false
    return true

  _allowEsc: =>
    @allowEsc = true
    return true

  _add: (e, data) =>
    @_updateTitle()
    @_drawProgess(e, data)
    @_updateButtonText()

  _updateTitle: =>
    $title = $('#asset_title')
    val = $title.val()
    if @titleCounter == 2 && val != ''
      $title.data('original-value', val)
      newVal = val + " #2"
      $title.val(newVal)
    else if @titleCounter > 2 && val != ''
      newVal = val.replace(/(.*)#\d+/, "$1 ##{@titleCounter}")
      $title.val(newVal)
    @titleCounter += 1

  _updateButtonText: ->
    $('#choose-files').text('Choose Another File')

  _resetCounter: =>
    $('#asset_title').val($('#aset_title').data('original-value'))
    @titleCounter = 1

  _drawProgess: (e, data) =>
    ReactDOM.render(
      React.createElement(AssetProgress, file: data.files[0]),
      @$progress[0]
    )
    data.context = @$progress
    data.submit()

  _updateProgess: (e, data) ->
    if data.context
      currentProgress = parseInt(data.loaded / data.total * 100, 10)
      data.context.find('.progress__bar').css('width', currentProgress + '%')

  _progressBarStatus: (context, status) ->
    # status accepts: warning(orange), success(green), danger(red)
    $progressBar = context.find('.progress__bar')
    $progressBar.addClass('.progress__bar--' + status)

  _errorMessage: (e, data) =>
    @_progressBarStatus(data.context, 'danger')

module.exports = AssetUploader
