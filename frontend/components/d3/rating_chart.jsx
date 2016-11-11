import React from 'react';
import ReactDOM from 'react-dom';
import createGraph from './create_graph';
import * as d3 from 'd3';

class RatingChart extends React.Component {
  componentDidMount() {
    const dom = ReactDOM.findDOMNode(this);
    createGraph(dom, this.props);
  }
  componentDidUpdate() {
    const dom = ReactDOM.findDOMNode(this);
    d3.select(dom).select('svg').remove();
    createGraph(dom, this.props);
    return(false);
  }
  render() {
    return (
      <div id='container' className="rating-chart-container" />
    );
  }
}

RatingChart.propTypes = {
  width: React.PropTypes.number,
  height: React.PropTypes.number,
};

export default RatingChart;
