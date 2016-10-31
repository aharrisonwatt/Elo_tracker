import React from 'react';

class RatingPlayerFilter extends React.Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e) {
    this.props.updateFilterText(e.currentTarget.value);
  }

  render() {
    return (
      <input
        type="text"
        placeholder="Find a Player"
        value={this.props.filterText}
        onChange={this.handleChange}
      />
    );
  }
}

RatingPlayerFilter.propTypes = {
  updateFilterText: React.PropTypes.func.isRequired,
  filterText: React.PropTypes.string.isRequired
};

export default RatingPlayerFilter;
