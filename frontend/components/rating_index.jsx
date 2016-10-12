import React from 'react';
import RatingFilter from './rating_filter';

class RatingIndex extends React.Component{
  componentDidMount(){
    this.props.requestRatings();
  }
  render(){
    let games;
    if (this.props.ratings['ratings']){
      let game_object = this.props.ratings['ratings'];
      games = Object.keys(game_object);
    }
    return (
      <div>
        <RatingFilter games={games} />
      </div>
    )
  }
}

export default RatingIndex
