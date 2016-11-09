import React from 'react';
import ReactDOM from 'react-dom';
import createGraph from './create_graph';

class RatingChart extends React.Component {

  componentDidMount() {
    const dom = ReactDOM.findDOMNode(this);
    createGraph(dom, this.props);
  }

  render() {
    return (
      <div className="rating-chart-container" />
    );
  }
}

RatingChart.propTypes = {
  width: React.PropTypes.number,
  height: React.PropTypes.number,
};

export default RatingChart;
