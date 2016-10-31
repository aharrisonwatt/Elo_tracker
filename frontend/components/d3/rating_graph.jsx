import React from 'react';
import { LineChart } from 'react-d3';

class RatingGraph extends React.Component {
  render() {
    const chartData = [{
      name: 'rank',
      values: this.props.data,
    }];
    const parseDate = d3.time.format("%Y-%m-%d").parse;
    const width = this.props.width,
      height = this.props.height,
      margins = { left: 100, right: 100, top: 50, bottom: 50 },
      chartSeries = [
        {
          field: 'rank',
          name: 'Rank',
          color: '#000000',
        },
      ],
      x = function(d) {
        return parseDate(d.date);
      },
      xScale = 'time';
    return (
      <LineChart
        margins={margins}
        data={chartData}
        width={width}
        height={height}
        chartSeries={chartSeries}
        x={x}
        xScale={xScale}
      />
    );
  }
}

RatingGraph.propTypes = {
  width: React.PropTypes.number,
  height: React.PropTypes.number,
  data: React.PropTypes.arrayOf(React.PropTypes.object),
};

export default RatingGraph;
