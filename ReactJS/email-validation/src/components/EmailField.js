import React from 'react';

class EmailField extends React.Component {
  render() {
    return(
      <label><span className="reader">Email Address:</span>
        <input value={this.props.email} />
      </label>
    );
  }
}

export default EmailField;
