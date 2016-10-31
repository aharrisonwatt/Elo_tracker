import React from 'react';

class RatingDisplay extends React.Component {
  render() {
    let ratingDisplay = <div />;
    if (this.props.gameObject) {
      ratingDisplay = (
        <div>
          <h2>rank: {this.props.gameObject.rank}</h2>
          <h2>MMR: {this.props.gameObject.rating}</h2>
        </div>
      );
    }
    return (
      <div>
        {ratingDisplay}
      </div>
    );
  }
}

RatingDisplay.propTypes = {
  gameObject: React.PropTypes.shape({
    rank: React.PropTypes.number,
    rating: React.PropTypes.number,
  }),
};

export default RatingDisplay;
