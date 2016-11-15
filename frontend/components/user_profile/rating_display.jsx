import React from 'react';
import RatingChart from '../d3/rating_chart';

class RatingDisplay extends React.Component {
  render() {
    console.log(2, this.props.gameObject)
    let ratingDisplay = <div />;
    let ratingChart = <div />;
    if (this.props.gameObject) {
      ratingDisplay = (
        <div className='user-stats-container'>
          <h2>rank: {this.props.gameObject.rank}</h2>
          <h2>MMR: {this.props.gameObject.rating}</h2>
        </div>
      );
      ratingChart = (
        <RatingChart
          data={this.props.gameObject.ratings}
        />
      );
    }
    return (
      <div className="ratings-container">
        {ratingDisplay}
        {ratingChart}
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
