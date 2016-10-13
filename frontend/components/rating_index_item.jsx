import React from 'react';

class RatingIndexItem extends React.Component{
  render () {
    let player_info;
    if (this.props.player){
      let player = this.props.player;
      player_info =
      <div>
        <div>{player[0]}</div>
        <div>{player[1]}</div>
      </div>
    }
    return(
      <li>
        {player_info}
      </li>
    )
  }
}

export default RatingIndexItem
