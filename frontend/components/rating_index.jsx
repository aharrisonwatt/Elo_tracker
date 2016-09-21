import React  from 'react';

class RatingIndex extends React.Component{
  componentDidMount(){
    this.props.requestRatings();
  }
  render(){
    return (
      <h1>Hello World </h1>
    )
  }
}

export default RatingIndex
