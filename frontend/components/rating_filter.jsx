import React from 'react';

class RatingFilter extends React.Component{
  handleChange(e) {
    debugger
  }

  render () {
    let options;
    if (this.props.games){
      options = this.props.games.map( game_name => (
        <option value={game_name} key={game_name}>
          {game_name}
        </option>
      ))
    }
    return (
      <select onChange={this.handleChange}>
        {options}
      </select>
    )
  }
}

export default RatingFilter
