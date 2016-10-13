import React from 'react';

class RatingIndexItem extends React.Component{
  render () {
    let player_info;
    if (this.props.player){
      let player = this.props.player;
      player_info =
        <li className='rating-index-item' key={player[0]}>
          <span className='rating-index-item-element'>{player[0]}</span>
          <span className='rating-index-item-element'>{player[1]}</span>
        </li>
    }
    return(
      player_info
    )
  }
}

export default RatingIndexItem
