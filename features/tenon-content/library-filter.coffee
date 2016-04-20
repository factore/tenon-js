$ = require('jquery')

class LibraryFilter
  constructor: ->
    $(document).on('keyup', '.tn-tc-library input.filter', @filter)

  filter: =>
    val = $('.tn-tc-library input.filter').val()
    if val == ''
      @_clearFilter()
    else
      @_hideNonMatched(val)

  _hideNonMatched: (val) =>
    $('.tn-tc-library a.add_fields').hide()
    $('.tn-tc-library a.add_fields[data-searchable-title*="' + val.toLowerCase() + '"]').show()

  _clearFilter: =>
    $('.tn-tc-library a.add_fields').show()

module.exports = LibraryFilter
