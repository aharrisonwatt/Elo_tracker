import React from 'react';
import PlayerIndexCards from './player_index_cards';
import RatingPlayerFilter from '../rating_index/rating_player_filter';

class PlayerSearchContainer extends React.Component {
  constructor(props) {
    super(props);
    this.updateFilterText = this.updateFilterText.bind(this);
    this.state = {
      filterText: '',
    };
  }
  updateFilterText(text) {
    this.setState({ filterText: text });
  }
  render() {
    return (
      <div>
        <RatingPlayerFilter
          updateFilterText={this.updateFilterText}
          filterText={this.state.filterText}
        />
        <PlayerIndexCards
          players={this.props.players}
          filterText={this.state.filterText}
        />
      </div>
    );
  }
}

PlayerSearchContainer.propTypes = {
  players: React.PropTypes.array.isRequired,
};

export default PlayerSearchContainer;
