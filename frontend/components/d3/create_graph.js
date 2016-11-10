import * as d3 from 'd3';

function createGraph(dom, props) {
  // Set default attributes
  const data = props.data;
  const margin = {
    top: 30,
    right: 20,
    bottom: 30,
    left: 50,
  };
  const width = 600 - margin.left - margin.right;
  const height = 270 - margin.top - margin.bottom;

  // Parse Date
  const parseDate = d3.timeParse('%Y-%m-%d');

  // Set Ranges
  const x = d3.scaleTime().range([0, width]);
  const y = d3.scaleLinear().range([height, 0]);

  console.log('Define Axes');
  const xAxis = d3.axisBottom(x).ticks(4);
  const yAxis = d3.axisLeft(y).ticks(5);
  console.log('Define line');
  const valueline = d3.line()
  .x(function(d) { return x(d.date); })
  .y(function(d) { return y(d.rating); });

  console.log('add SVG');
  const svg = d3.select('body')
  .append('svg')
  .attr('width', width + margin.left + margin.right)
  .attr('height', height + margin.top + margin.bottom);

  svg.append('g')
  .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

  data.forEach(function(d) {
    d.date = parseDate(d.date);
  });

  x.domain(d3.extent(data, function(d) { return d.date; }));
  y.domain([0, d3.max(data, function(d) { return d.rating; })]);

  console.log('Add the valueline path.')
  svg.append('path')
  .attr('class', 'line')
  .attr('d', valueline(data));

  console.log('Add the X Axis');
  svg.append('g')
  .attr('class', 'x axis')
  .attr('transform', "translate(0," + height + ")")
  .call(xAxis);

  console.log('Add the Y Axis');
  svg.append("g")
  .attr("class", "y axis")
  .call(yAxis);
}
export default createGraph;
