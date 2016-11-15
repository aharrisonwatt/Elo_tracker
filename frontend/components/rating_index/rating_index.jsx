// TODO: refactor out filterText

import React from 'react';
import RatingGameFilter from './rating_game_filter';
import RatingIndexList from './rating_index_list';
import RatingPlayerFilter from './rating_player_filter';
import PlayerSearchContainer from '../player_search/player_search_container';

class RatingIndex extends React.Component {
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

  updateGameFilter(gameName) {
    this.setState({ gameFilter: gameName });
  }

  updateFilterText(text) {
    this.setState({ filterText: text });
  }

  render() {
    let games;
    let players;
    if (this.props.ratings.ratings) {
      const gameObject = this.props.ratings.ratings;
      games = Object.keys(gameObject);
      if (this.state.gameFilter === '') {
        this.state.gameFilter = games[0];
      }
      players = gameObject[this.state.gameFilter];
    }
    return (
      <div className="rating-index">
        <div className="rating-index-container">
          <div className="rating-index-ratings-container">
            <RatingGameFilter
              updateGameFilter={this.updateGameFilter}
              games={games}
              currentFilter={this.state.gameFilter}
            />
            <RatingIndexList
              players={players}
              filterText={this.state.filterText}
            />
          </div>
          <PlayerSearchContainer
            players={players}
          />
        </div>
      </div>
    );
  }
}
RatingIndex.propTypes = {
  ratings: React.PropTypes.shape({
    ratings: React.PropTypes.object
  }),
  requestRatings: React.PropTypes.func
};

export default RatingIndex;
