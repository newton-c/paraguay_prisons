
*/ this bar chart shows the population of prisons as a percentage of their 
official capacity, to visualize how over (or occasionally) populated they
are */

// create a 640x450 canvase with some padding around the edges
const margin = {top: 20, right: 20, bottom: 20, left: 20},
	width = 640 - margin.left - margin.right,
	height = 450 - margin.top - margin.bottom

const svg.select("#overpop_bar")
	.append("svg")
		.attr("height", height + margin.top + margin.bottom)
		.attr("width", width + margin.left + margin.right)
	.append("g")
		.attr("transform", `translate(${margin.left}, ${margin.top})`)