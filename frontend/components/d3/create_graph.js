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
  const width = 1200 - margin.left - margin.right;
  const height = 500 - margin.top - margin.bottom;

  // Parse Date
  const parseDate = d3.timeParse('%Y-%m-%d');

  // Set Ranges
  const x = d3.scaleTime().rangeRound([0, width]);
  const y = d3.scaleLinear().rangeRound([height, 0]);
  // Define Axes
  const xAxis = d3.axisBottom(x).ticks(4);
  const yAxis = d3.axisLeft(y).ticks(5);

  // Define line
  const valueline = d3.line()
  .x(function(d) { return x(d.date); })
  .y(function(d) { return y(d.rating); });

  // 'add SVG'
  const svg = d3.select(dom)
  .append('svg')
  .attr('width', width + margin.left + margin.right)
  .attr('height', height + margin.top + margin.bottom);

  svg.append('g')
  .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');
  data.forEach(function(d) {
    if (typeof d.date === 'string') {
      d.date = parseDate(d.date);
    }
  });
  x.domain(d3.extent(data, function(d) { return d.date; }));
  y.domain([
    d3.min(data, function(d) { return d.rating; }),
    d3.max(data, function(d) { return d.rating; })
  ]);

  // Add the valueline path
  svg.append('path')
  .datum(data)
  .attr('class', 'line')
  .attr('d', valueline);

  // Add the X Axis
  svg.append('g')
  .attr('class', 'x axis')
  .attr('transform', "translate(0," + height + ")")
  .call(xAxis);

  // Add the Y Axis
  svg.append("g")
  .attr("class", "y axis")
  .call(yAxis);
}
export default createGraph;
