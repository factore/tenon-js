import React from 'react';

Tenon.RI.DefaultFilterOverlay = (props) => {
  return (
    <div className="toolbar toolbar--filter toolbar--overlay-z2">
      <div className="toolbar__action toolbar__action--back">
        <a
          href="#!"
          className="action-icon">
          <i className="material-icons">close</i>
          Close
        </a>
      </div>

      <div className="toolbar__content">
        <p className="toolbar__text">
          {props.data.records.size} Results.
        </p>
      </div>
    </div>
  );
};
