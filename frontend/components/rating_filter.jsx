import React from 'react';

class RatingFilter extends React.Component{
  render () {
    let options;
    if (this.props.games){
      options = this.props.games.map( game_name => (
        <option value={game_name}>{game_name}</option>
      ))
    }
    return (
      <select>
        {options}
      </select>
    )
  }
}

export default RatingFilter
