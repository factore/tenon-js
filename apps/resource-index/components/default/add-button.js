import React from 'react';

Tenon.RI.DefaultAddButton = (props) => {
  return (
    <a className="fab fab--bottom-right" href={props.newPath}>
      <i className="material-icon">add</i>
    </a>
  );
};
