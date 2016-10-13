import React from 'react';
import RatingFilter from './rating_filter';
import RatingIndexList from './rating_index_list';

class RatingIndex extends React.Component{
  constructor(props) {
    super(props);
    this.handleUserInput = this.handleUserInput.bind(this);
    this.state = {
      gameFilter: 'Street Fighter V'
    };
  }
  componentDidMount() {
    this.props.requestRatings();
  }

  handleUserInput(game_name) {
    this.state = {
      gameFilter: game_name
    }
    this.forceUpdate();
  }

  render() {
    let games;
    let players;
    if (this.props.ratings['ratings']){
      let game_object = this.props.ratings['ratings'];
      games = Object.keys(game_object);
      players = game_object[this.state.gameFilter];
    }
    return (
      <div className='rating-index'>
        <RatingFilter onUserInput={this.handleUserInput} games={games} />
        <RatingIndexList players={players} />
      </div>
    )
  }
}

export default RatingIndex
