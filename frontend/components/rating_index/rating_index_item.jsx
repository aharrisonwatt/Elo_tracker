import React from 'react';

class RatingIndexItem extends React.Component {
  constructor(props) {
    super(props);
    this.handleClick = this.handleClick.bind(this);
  }
  handleClick(e) {
    this.props.onClick(e.currentTarget.childNodes[1].innerHTML);
  }
  render() {
    let playerInfo;
    if (this.props.player) {
      const player = this.props.player;
      playerInfo =
        (<tr
          className="rating-index-item"
          key={player[0]}
          onClick={this.handleClick}
         >
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
  rank: React.PropTypes.number.isRequired,
  onClick: React.PropTypes.func.isRequired
};

export default RatingIndexItem;
