ModalWindows = require('tenon/features/modal-windows')
AssetUploader = require('tenon/features/asset-uploader')

class AssetAttachment
  constructor: (@$browseButton, @$container) ->
    @$assetField = @_getAssetField()
    @_setupAssetUploading()
    @$container.on('assetPicked', @_setFields)
    window.ReactRailsUJS.mountComponents('#pick-asset')

  _setupAssetUploading: =>
    @uploader = new AssetUploader(@_uploadComplete)
    @uploader.initialize('#new_asset')

  _uploadComplete: (e, data) =>
    asset = data.result.record
    @_setFields(e, {
      id: asset.id,
      thumbnailPath: asset.style_urls.thumbnail,
      mediumPath: asset.style_urls.medium,
      filename: asset.display_name
    })
    ModalWindows.closeModals()

  _setFields: (e, data) =>
    @$assetField.find('[data-asset-id-field]').val(data.id)
    @$assetField.find('[data-asset-thumbnail]')
      .html("<img src='#{data.thumbnailPath}' />")
    @$assetField.find('[data-asset-info]').html(data.filename)
    @$assetField.find('[data-asset-remove]').show()
    ModalWindows.closeModals()

  _getAssetField: =>
    if @$browseButton.data('asset-field')
      $(@$browseButton.data('asset-field'))
    else
      @$browseButton.closest('.asset-field, .tn-tc-asset-field')

module.exports = AssetAttachment;
