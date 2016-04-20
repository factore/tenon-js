Aesthetics = require('./aesthetics')
BottombarToggler = require('./bottombar-toggler')
CaptionToggler = require('./caption-toggler')
ColumnSizing = require('./column-sizing')
ColumnSwap = require('./column-swap')
Editor = require('./editor')
ImageControls = require('./image-controls')
ImageLinks = require('./image-links')
LibraryFilter = require('./library-filter')
Sortable = require('./sortable')
StretchToFill = require('./stretch-to-fill')
WrappedSizing = require('./wrapped-sizing')

$ = require('jquery')

class Base
  constructor: ->
    $container = $('.tn-tc__rows')
    new Aesthetics($container)
    new BottombarToggler($container)
    new CaptionToggler($container)
    new ColumnSizing($container)
    new ColumnSwap($container)
    new Editor($container)
    new ImageControls($container)
    new ImageLinks($container)
    new LibraryFilter($container)
    new Sortable($container)
    new StretchToFill($container)
    new WrappedSizing($container)

module.exports = Base
