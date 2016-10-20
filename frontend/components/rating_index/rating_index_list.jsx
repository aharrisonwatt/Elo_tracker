import React from 'react';
import RatingIndexItem from './rating_index_item';

class RatingIndexList extends React.Component{
  render () {
    let players;
    if (this.props.players){
      let filterText = this.props.filterText;
      players = this.props.players.map(player => {
        if (player[0].indexOf(filterText) === -1){
          return;
        }
        else {
          return<RatingIndexItem player={player} key={player[0]}/>;
        }
      });
    }
    return (
      <ol className='rating-index-list'>
        {players}
      </ol>
    )
  }
}

export default RatingIndexList
