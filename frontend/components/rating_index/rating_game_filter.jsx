import React from 'react';

class RatingGameFilter extends React.Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e) {
    this.props.updateGameFilter(e.currentTarget.value);
  }

  render() {
    let options;
    if (this.props.games) {
      const games = this.props.games;
      options = games.map(gameName => (
        <option
          className="rating-filter-option"
          value={gameName}
          key={gameName}
        >
          {gameName}
        </option>
      ));
    }
    return (
      <select
        defaultValue={this.props.currentFilter}
        className="rating-filter"
        onChange={this.handleChange}
      >
        {options}
      </select>
    );
  }
}

RatingGameFilter.propTypes = {
  games: React.PropTypes.arrayOf(React.PropTypes.string),
  updateGameFilter: React.PropTypes.func.isRequired,
  currentFilter: React.PropTypes.string.isRequired
};

export default RatingGameFilter;
