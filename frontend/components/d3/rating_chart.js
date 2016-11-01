import * as d3 from 'd3';

const ratings = [
  {
    rating: 1400,
    date: '2014-08-07',
  },
  {
    rating: 1520,
    date: '2014-08-15',
  },
  {
    rating: 1602,
    date: '2014-08-21',
  },
  {
    rating: 1599,
    date: '2014-08-29',
  },
  {
    rating: 1669,
    date: '2014-09-11',
  },
  {
    rating: 1716,
    date: '2014-09-25',
  },
];
// Set Dimensions
const margin = {
  top: 30,
  right: 20,
  bottom: 30,
  left: 50,
};
const width = 600 - margin.left - margin.right;
const height = 270 - margin.top - margin.bottom;

// Parse Date
const parseDate = d3.time.format("%Y-%m-%d").parse

// Set Ranges
const y = d3.scaleLinear().range([height, 0]);
const x = d3.scaleTime().range([0, width]);

// Define Axes
const xAxis = d3.svg.axis.scale(x).orient('bottom').ticks(4);
const yAxis = d3.svg.axis().scale(y).orient('left').ticks(5);

// Define line
const valueline = d3.svg.line()
      .x(function(d) { return x(d.date); })
      .y(function(d) { return y(d.rating); });

//add SVG
const svg = d3.select('body')
  .append('svg')
    .attr('width', width + margin.left + margin.right)
    .attr('height', height + margin.top + margin.bottom);

svg.append('g')
  .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');
