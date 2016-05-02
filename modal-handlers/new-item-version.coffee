URI = require('urijs')
ModalWindows = require('tenon/features/modal-windows')

class NewItemVersion
  constructor: (@$link, @$el, @$template) ->
    @$itemForm = $('form[data-version-create-path]')
    @$template.on('submit', @submitItemVersion)

  submitItemVersion: (e) =>
    e.preventDefault()
    jqxhr = $.ajax
      url: @$template.attr('action')
      data: @_formData()
      method: 'POST'
    jqxhr.done(ModalWindows.closeModals())
    jqxhr.fail(@_failure())

  _formData: =>
    itemFormData = URI("?" + @$itemForm.serialize()).query(true)

    # Serialize the checkbox in a way that rails can get down with
    @$itemForm.find("input:checkbox").each ->
      if !(@.checked)
        itemFormData[@.name] = "0"
      else
        itemFormData[@.name] = "1"

    versionFormData = URI("?" + @$template.serialize()).query(true)
    delete(itemFormData._method)
    $.extend(itemFormData, versionFormData)

  _failure: =>
    msg = "Failed to save draft."
    @$template.prepend(msg)

module.exports = NewItemVersion
