import React from 'react';
import RatingGraph from '../d3/rating_graph';

class RatingDisplay extends React.Component {
  render() {
    let ratingDisplay = <div />;
    let ratingGraph = <div />;
    if (this.props.gameObject) {
      debugger
      ratingDisplay = (
        <div>
          <h2>rank: {this.props.gameObject.rank}</h2>
          <h2>MMR: {this.props.gameObject.rating}</h2>
        </div>
      );
      ratingGraph = (
        <RatingGraph
          data={this.props.gameObject.ratings}
          width={500}
          height={300}
        />
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
    ratings: React.PropTypes.array,
  }),
};

export default RatingDisplay;
