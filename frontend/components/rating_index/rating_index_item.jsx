import React from 'react';

class RatingIndexItem extends React.Component {
  render() {
    let playerInfo;
    if (this.props.player) {
      const player = this.props.player;
      playerInfo =
        (<tr className="rating-index-item" key={player[0]}>
          <td className="rating-index-item-element">{this.props.rank}</td>
          <td className="rating-index-item-element">{player[0]}</td>
          <td className="rating-index-item-element">{player[1]}</td>
        </tr>);
    }
    return (
      playerInfo
    );
  }
}

RatingIndexItem.propTypes = {
  player: React.PropTypes.array.isRequired,
  rank: React.PropTypes.number.isRequired
};

export default RatingIndexItem;
