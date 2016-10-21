import React from 'react';

class RatingIndexItem extends React.Component{
  render () {
    let player_info;
    if (this.props.player){
      let player = this.props.player;
      player_info =
        <tr className='rating-index-item' key={player[0]}>
          <td className='rating-index-item-element'>{this.props.rank}</td>
          <td className='rating-index-item-element'>{player[0]}</td>
          <td className='rating-index-item-element'>{player[1]}</td>
        </tr>
    }
    return(
      player_info
    )
  }
}

export default RatingIndexItem
