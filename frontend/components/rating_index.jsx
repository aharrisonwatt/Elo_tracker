import React from 'react';
import RatingFilter from './rating_filter';
import RatingIndexList from './rating_index_list';

class RatingIndex extends React.Component{
  componentDidMount(){
    this.props.requestRatings();
  }
  render(){
    let games;
    let players;
    if (this.props.ratings['ratings']){
      let game_object = this.props.ratings['ratings'];
      games = Object.keys(game_object);
      players = game_object['Street Fighter V'];
    }
    return (
      <div>
        <RatingFilter games={games} />
        <RatingIndexList players={players} />
      </div>
    )
  }
}

export default RatingIndex
