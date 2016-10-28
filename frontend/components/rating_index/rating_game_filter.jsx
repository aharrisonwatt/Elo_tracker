import React from 'react';

class RatingGameFilter extends React.Component{
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e) {
    this.props.updateGameFilter(e.currentTarget.value)
  }

  render () {
    let options;
    if (this.props.games){
      let games = this.props.games;
      options = games.map( game_name => (
        <option className='rating-filter-option' value={game_name} key={game_name}>
          {game_name}
        </option>
      ))
    }
    return (
      <select defaultValue={this.props.currentFilter} className='rating-filter' onChange={this.handleChange}>
        {options}
      </select>
    )
  }
}

export default RatingGameFilter
