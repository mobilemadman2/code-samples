import React from 'react';

class LoadingIcon extends React.Component {
  render() {
    return(
      <div className={`${this.props.parentName}__loading-icon`}>
        <svg
          version="1.1"
          x="0px" y="0px"
      	  viewBox="0 0 75 46"
          xmlSpace="preserve"
          enableBackground="new 0 0 75 46"
          xmlns="http://www.w3.org/2000/svg"
          xmlnsXlink="http://www.w3.org/1999/xlink"
          className={`${this.props.parentName}__svg`}
          >
      	  <circle fill="#F35B2C" cx="66.25" cy="38.25" r="7.75"/>
      	  <circle fill="#F88F1E" cx="46.75" cy="38.25" r="7.75"/>
      	  <circle fill="#8DC643" cx="27.25" cy="38.25" r="7.75"/>
      	  <circle fill="#1DA285" cx="7.75" cy="38.25" r="7.75"/>
        </svg>
      </div>
    );
  }
}

export default LoadingIcon;
