import React from 'react';

Tenon.RI.DefaultSortOrderItem = (props) => {
  const classNames = ['dropdown__item'];
  const { title, order } = props;
  const { order_field, order_direction } = props.data.query;
  const { orderBy } = props.handlers;
  const [field, direction] = order.split(':');

  if (field === order_field && direction === order_direction) {
    classNames.push('dropdown__action--is-active');
  }

  return (
    <li className={classNames.join(' ')}>
      <a
        href="#!"
        className="dropdown__action action-icon"
        onClick={(e) => orderBy(e, field, direction)}>
        <span>
          {title}
          <div className="dropdown__active-icon">
            <i className="material-icon">check</i>
          </div>
        </span>
      </a>
    </li>
  );
};
