import { hashHistory } from 'react-router';
import React from 'react';
import RatingIndexItem from './rating_index_item';

class RatingIndexList extends React.Component {
  constructor(props) {
    super(props);
    this.loadPlayerProfile = this.loadPlayerProfile.bind(this);
  }
  loadPlayerProfile(username) {
    hashHistory.push(username);
  }
  render() {
    let players;

    if (this.props.players) {
      const filterText = this.props.filterText;
      players = this.props.players.map((player, i) => {
        if (player[0].toLowerCase().indexOf(filterText.toLowerCase()) === -1) {
          return;
        }
        else {
          return (
            <RatingIndexItem
              rank={i + 1}
              player={player}
              key={player[0]}
              onClick={this.loadPlayerProfile}
            />
          );
        }
      });
    }

    return (
      <table className="rating-index-table">
        <thead>
          <tr>
            <th>Rank</th>
            <th>Player</th>
            <th>MMR</th>
          </tr>
        </thead>
        <tbody>
          {players}
        </tbody>
      </table>
    );
  }
}

RatingIndexList.propTypes = {
  players: React.PropTypes.arrayOf(React.PropTypes.array),
  filterText: React.PropTypes.string.isRequired
};

export default RatingIndexList;
