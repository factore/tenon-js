// Vendor
require('./querystring.underscore');
require('./inflection.underscore');
window._ = require('lodash');
import $ from 'jquery';

// Resources
import AssetCropping from './features/asset-cropping';
import AssetDetachment from './features/asset-detachment';
import CocoonHooks from './features/cocoon-hooks';
import Dropdown from './features/dropdown';
import Expandable from './features/expandable';
import Flash from './features/flash';
import ModalWindows from './features/modal-windows';
import FocusError from './features/focus-error';
import GenericClassToggler from './features/generic-class-toggler';
import I18nFields from './features/i18n-fields';
import ItemVersionAutosave from './features/item-version-autosave';
import NavItemToggle from './features/nav-item-toggle';
import ProtectChanges from './features/protect-changes';
import SortableNestedFields from './features/sortable-nested-fields';
import Tabs from './features/tabs';
import TenonContentBase from './features/tenon-content/base';
import ToggleMainNav from './features/toggle-main-nav';

$.ajaxSetup({
  dataType: 'json',
  'beforeSend' : function(xhr) {
    xhr.setRequestHeader('Accept', 'application/json');
  }
});

window.Tenon = {
  RI: {},
  init: function() {
    // init pickadate
    // $('[data-behavior=datepicker]').pickadate();
    // $('[data-behavior=timepicker]').pickatime();

    new AssetCropping();
    new AssetDetachment();
    new CocoonHooks();
    new Dropdown();
    new Expandable();
    new Flash();
    new FocusError();
    new GenericClassToggler();
    new I18nFields();
    new ItemVersionAutosave();
    new ModalWindows();
    new NavItemToggle();
    new ProtectChanges();
    new SortableNestedFields();
    new Tabs();
    new TenonContentBase();
    new ToggleMainNav();
  }
};

Tenon.ResourceIndexRoot = require('./apps/resource-index/containers/root').default;

// Components
// import ResourceIndexRoot from './apps/resource-index/containers/root';
// import StandaloneList from './apps/resource-index/containers/standalone-list-root';
