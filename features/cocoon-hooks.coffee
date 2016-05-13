TenonContentBase = require('tenon/features/tenon-content/base')
Editor = require('tenon/features/editor')

class CocoonHooks
  constructor: ->
    $(document).on('cocoon:after-insert', @afterInsert)

  afterInsert: (e, insertedItem) =>
    @$insertedItem = $(insertedItem)
    @_checkTenonContent()
    Editor.reinitInline()

  _checkTenonContent: ->
    if @$insertedItem.find('.tn-tc')
      new TenonContentBase

module.exports = CocoonHooks
