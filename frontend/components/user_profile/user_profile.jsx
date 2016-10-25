import React from 'react';

class UserProfile extends React.Component{
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.requestUser(this.props.params.username);
  }

  render() {
    return(
      <div>
        <h1>Hello World</h1>
      </div>
    )
  }
}

export default UserProfile
