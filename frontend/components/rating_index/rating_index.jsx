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
      gameFilter: '',
      filterText: ''
    };
  }
  componentDidMount() {
    this.props.requestRatings();
  }

  updateGameFilter(game_name) {
    this.setState({gameFilter: game_name})
  }

  updateFilterText(text){
    this.setState({filterText: text})
  }

  render() {
    let games;
    let players;
    if (this.props.ratings['ratings']){
      let game_object = this.props.ratings['ratings'];
      games = Object.keys(game_object);
      if (this.state.gameFilter === ''){
        this.state.gameFilter = games[0];
      }
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
              games={games}
              currentFilter={this.state.gameFilter} />
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
