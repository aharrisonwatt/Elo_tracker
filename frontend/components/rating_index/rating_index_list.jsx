import { hashHistory } from 'react-router';
import React from 'react';
import RatingIndexItem from './rating_index_item';

class RatingIndexList extends React.Component {
  constructor(props) {
    super(props);
    this.loadPlayerProfile = this.loadPlayerProfile.bind(this);
    this.increaseIndex = this.increaseIndex.bind(this);
    this.decreaseIndex = this.decreaseIndex.bind(this);
    this.state = {
      index: 0,
    };
  }

  loadPlayerProfile(username) {
    hashHistory.push(username);
  }

  increaseIndex() {
    let newIndex = this.state.index + 10;
    if (newIndex > this.props.players.length) {
      newIndex = this.state.index;
    }
    this.setState({
      index: newIndex,
    });
  }

  decreaseIndex() {
    let newIndex = this.state.index - 10;
    if (newIndex < 0) {
      newIndex = 0;
    }
    this.setState({
      index: newIndex,
    });
  }

  render() {
    let indexItems;

    if (this.props.players) {
      const players = this.props.players;
      indexItems = [];
      for (let i = this.state.index; i < this.state.index + 10; i++) {
        const indexItem = (
          <RatingIndexItem
            rank={i + 1}
            player={players[i]}
            key={players[i][0]}
            onClick={this.loadPlayerProfile}
          />
      );
        indexItems.push(indexItem);
      }
    }

    return (
      <div>
        <table className="rating-index-table">
          <thead>
            <tr>
              <th>Rank</th>
              <th>Player</th>
              <th>ELO</th>
            </tr>
          </thead>
          <tbody>
            {indexItems}
          </tbody>
        </table>
        <div className="rating-index-buttons">
          <button className="pure-button" onClick={this.decreaseIndex}>pervious</button>
          <button className="pure-button" onClick={this.increaseIndex}>next</button>
        </div>
      </div>
    );
  }
}

RatingIndexList.propTypes = {
  players: React.PropTypes.arrayOf(React.PropTypes.array),
};

export default RatingIndexList;
