import classNames from 'classnames';
import React from 'react';
import ReactDOM from 'react-dom';

class QuickSearchOverlay extends React.Component {
  componentDidUpdate() {
    if (this.props.ui.quickSearchOpen) {
      const node = ReactDOM.findDOMNode(this._input);

      node.querySelectorAll(':scope > input[type=text]')[0].focus();
    }
  }

  render() {
    const {
      ui: { quickSearchOpen, filterDrawerOpen },
      childComponents: { QuickSearchInput, FilterDrawerToggle },
      actions: { toggleQuickSearch, toggleFilterDrawer, replaceQuery }
    } = this.props;

    const className = classNames({
      'toolbar': true,
      'toolbar--quick-search': true,
      'toolbar--overlay-z1': true,
      'toolbar--is-open': quickSearchOpen || filterDrawerOpen
    });

    return (
      <div className={className}>
        <div className="toolbar__actions toolbar__actions--left">
          <div className="toolbar__action">
            <a
              href="#!"
              className="action-icon"
              onClick={(e) => {
                e.preventDefault();
                toggleQuickSearch('off');
                toggleFilterDrawer('off');
                replaceQuery({ q: '', page: 1 });
              }}>
              <i className="material-icon">arrow_back</i>
              &nbsp;
              <span className="hide-on-min">Clear</span>
            </a>
          </div>
        </div>

        <div className="toolbar__content">
          <QuickSearchInput
            ref={(input) => this._input = input}
            { ...this.props } />
        </div>

        <div className="toolbar__actions toolbar__actions--right">
          <FilterDrawerToggle {...this.props} />
        </div>
      </div>
    );
  }
}

Tenon.RI.DefaultQuickSearchOverlay = QuickSearchOverlay;
