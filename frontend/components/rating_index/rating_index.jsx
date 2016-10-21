import React from 'react';
import RatingGameFilter from './rating_game_filter';
import RatingIndexList from './rating_index_list';
import RatingPlayerFilter from './rating_player_filter'

class RatingIndex extends React.Component{
  constructor(props) {
    super(props);
    this.updateGameFilter = this.updateGameFilter.bind(this);
    this.updateFilterText = this.updateFilterText.bind(this);
    this.state = {
      gameFilter: 'Street Fighter V',
      filterText: ''
    };
  }
  componentDidMount() {
    this.props.requestRatings();
  }

  updateGameFilter(game_name) {
    this.state['gameFilter'] = game_name
    this.forceUpdate();
  }

  updateFilterText(text){
    this.state['filterText'] = text
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
        <div className='rating-index-container'>
          <div className='rating-index-filter-container'>
            <RatingPlayerFilter
              updateFilterText={this.updateFilterText}
              filterText={this.state['filterText']} />
            <RatingGameFilter
              updateGameFilter={this.updateGameFilter}
              games={games} />
          </div>
          <RatingIndexList
            players={players}
            filterText={this.state['filterText']}/>
        </div>
      </div>
    )
  }
}

export default RatingIndex
