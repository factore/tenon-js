import React from 'react';
import Datepicker from './datepicker';

module.exports = (props) => {
  return (
    <div className="input-block">
      <label className="input-block__label">{props.label}</label>
      <Datepicker
        className="input-block__text-field"
        name={props.name}
        value={props.value}
        onChange={props.onChange} />
    </div>
  );
};
