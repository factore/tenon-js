
AssetAttachment = require('./asset-attachment')

class MultipleAssetAttachment extends AssetAttachment
  _uploadComplete: (e, data) ->
    @_addAssociation()
    super

  _addAssociation: ->
    $('.add_fields').click()
    @$assetField = $('.nested-fields .tn-tc-asset-field:last')

module.exports = MultipleAssetAttachment
