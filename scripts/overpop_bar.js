
/* this bar chart shows the population of prisons as a percentage of their 
official capacity, to visualize how over (or occasionally) populated they
are */

// create a 640x450 canvase with some padding around the edges
const margin = {top: 20, right: 20, bottom: 20, left: 20},
	width = 640 - margin.left - margin.right,
	height = 450 - margin.top - margin.bottom

const svg = d3.select("#overpop_bar")
	.append("svg")
		.attr("height", height + margin.top + margin.bottom)
		.attr("width", width + margin.left + margin.right)
	.append("g")
		.attr("transform", `translate(${margin.left}, ${margin.top})`)

d3.csv("https://raw.githubusercontent.com/newton-c/paraguay_prisons/main/data/overpop_data.csv").then(function(data) {
	data.overpopulation = Number(data.overpopulation)
		console.log(data);

	const x = d3.scaleLinear()
		.domain([0, d3.max(data, function(d) { return +d.overpopulation })])
		.range([0, width])

	svg.append("g")
		.attr("transform", `translate(0, ${height})`)
		.call(d3.axisBottom(x))
})