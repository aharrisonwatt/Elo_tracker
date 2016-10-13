import React from 'react';

class RatingIndexItem extends React.Component{
  render () {
    let player_info;
    if (this.props.player){
      let player = this.props.player;
      player_info =
        <li className='rating-index-item' key={player[0]}>
          <p className='rating-index-item-element'>{player[0]}</p>
          <p className='rating-index-item-element'>{player[1]}</p>
        </li>
    }
    return(
      player_info
    )
  }
}

export default RatingIndexItem
