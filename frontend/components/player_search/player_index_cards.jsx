import React from 'react';
import { hashHistory } from 'react-router';

class PlayerIndexCards extends React.Component {
  constructor(props) {
    super(props);
    this.onClick = this.onClick.bind(this);
  }
  onClick(e) {
    hashHistory.push(e.currentTarget.value);
  }

  render() {
    let playerCards;
    if (this.props.players) {
      const filterText = this.props.filterText;
      if (filterText !== ''){
        var playerCardCount = 0;
        playerCards = this.props.players.map((player) => {
          if (player[0].toLowerCase().indexOf(filterText.toLowerCase()) === -1 ||
              playerCardCount === 10) {
            return;
          }
          else {
            playerCardCount += 1;
            return (
              <div onClick={this.Click}>
                {player}
              </div>
            );
          }
        });
      }
    }
    return (
      <div className="player-cards-container">
        {playerCards}
      </div>
    )
  }
}

PlayerIndexCards.propTypes = {
  onClick: React.PropTypes.func.isRequired,
  players: React.PropTypes.array.isRequired,
};

export default PlayerIndexCards;
