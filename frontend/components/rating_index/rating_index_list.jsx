import React from 'react';
import RatingIndexItem from './rating_index_item';

class RatingIndexList extends React.Component{
  render () {
    let players;
    if (this.props.players){
      let filterText = this.props.filterText;
      players = this.props.players.map((player, i) => {
        if (player[0].indexOf(filterText) === -1){
          return;
        }
        else {
          return<RatingIndexItem rank={i + 1} player={player} key={player[0]}/>;
        }
      });
    }
    return (
      <ul className='rating-index-list'>
        {players}
      </ul>
    )
  }
}

export default RatingIndexList
