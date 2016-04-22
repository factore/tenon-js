

# This is the TenonContent Editor, not the base Editor
class Editor
  constructor: ->
    $(document).on('cocoon:after-insert', '.tn-tc__rows', @_rowInserted)
    $(document).on('cocoon:after-remove', '.tn-tc__rows', @_rowRemoved)
    $(document).on('input keypress paste change', '.editable-text', @_contentUpdated)
    for div in $('.tn-tc')
      @_updateButtons($(div))

    CKEDITOR.on 'instanceReady', ->
      require('tenon/features/editor').watchChanges()

  _rowInserted: (e) =>
    # Reactivate Editor
    $wrap = $(e.currentTarget).closest('.tn-tc')
    @_redrawCkeditor()
    @_updateButtons($wrap)

  _rowRemoved: (e) =>
    @_updateButtons($(e.currentTarget).closest('.tn-tc'))

  _contentUpdated: (e) =>
    $editable = $(e.currentTarget)
    $editable.next('input[type=hidden]').val($editable.html())

  _updateButtons: ($wrap)=>
    if $wrap.find('.tn-tc__row:visible').length == 0
      $wrap.find('[data-tn-tc-add-content]').show()
      $wrap.find('.tn-tc-pop-out').hide()
    else
      $wrap.find('[data-tn-tc-add-content]').hide()
      $wrap.find('.tn-tc-pop-out').show()

  _redrawCkeditor: =>
    Tenon.features.Editor.reinitInline()

module.exports = Editor
