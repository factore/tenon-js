module.exports =
  reinitInline: ->
    for key in Object.keys(CKEDITOR.instances)
      instance = CKEDITOR.instances[key]
      instance.destroy(true) if instance?.editable()?.isInline()
      if CKEDITOR.instances[key]
        delete CKEDITOR.instances[key]
    CKEDITOR.inlineAll()

  watchChanges: ->
    updateElement = (el) ->
      $el = $(el)
      $el.next('input[type=hidden]').val($el.html())

    for key in Object.keys(CKEDITOR.instances)
      instance = CKEDITOR.instances[key]
      if instance?.editable()?.isInline()
        # Watch changes via Source
        instance.on 'mode', ->
          editable = instance.editable()
          editable.attachListener editable, 'input', (e) ->
            updateElement(e.editor.element.$)

        # Watch changes in the main editor
        instance.on 'change', (e) ->
          updateElement(e.editor.element.$)
