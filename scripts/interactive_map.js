
    // The svg
    var svg = d3.select("svg"),
        width = +svg.attr("width"),
        height = +svg.attr("height");
    
    // Map and projection
    var projection = d3.geoMercator()
        .center([-56, -24.3])                // GPS of location to zoom on
        .scale(3500)                       // This is like the zoom
        .translate([ width/2, height/2 ])
    
    Create data for circles:
    var markers = [
      {long: -57.648693, lat: -25.30886, group: "A",  size: 1530  / 20, name: "Tacumbú"}, // Tacumbú official
      {long: -57.648693, lat: -25.30886, group: "B",  size: 1364  / 20, name: "Tacumbú"}, // Tacumbú pretiral
      {long: -57.648693, lat: -25.30886, group: "C",  size: 1030  / 20, name: "Tacumbú"}, // Tacumbú convicted
      {long: -57.648693, lat: -25.30886, group: "D",  size: 2394  / 20, name: "Tacumbú"}, // Tacumbú total
      {long: -57.355278, lat: -25.123333, group: "A",  size: 408  / 20, name: "Emboscada"}, // Emboscada official
      {long: -57.355278, lat: -25.123333, group: "B",  size: 1117  / 20, name: "Emboscada"}, // Emboscada pretiral
      {long: -57.355278, lat: -25.123333, group: "C",  size: 248  / 20, name: "Emboscada"}, // Emboscada convicted
      {long: -57.355278, lat: -25.123333, group: "D",  size: 1365  / 20, name: "Emboscada"}, // Emboscada total
      {long: -55.716667, lat: -22.566667, group: "A",  size: 920 / 20, name: "Pedro Juan\nCaballero"}, // Pedro Juan Caballero official
      {long: -55.716667, lat: -22.566667, group: "B",  size: (565 + 27) / 20, name: "Pedro Juan\nCaballero"}, // Pedro Juan Caballero pretiral
      {long: -55.716667, lat: -22.566667, group: "C",  size: (207 + 17) / 20, name: "Pedro Juan\nCaballero"}, // Pedro Juan Caballero convicted
      {long: -55.716667, lat: -22.566667, group: "D",  size: 816 / 20, name: "Pedro Juan\nCaballero"}, // Pedro Juan Caballero total
      {long: -54.616667, lat: -25.516667, group: "A",  size: 700 / 20, name: "Ciudad\ndel Este"}, // Ciudad del Este official
      {long: -54.616667, lat: -25.516667, group: "B",  size: 946 / 20, name: "Ciudad\ndel Este"}, // Ciudad del Este pretiral
      {long: -54.616667, lat: -25.516667, group: "C",  size: 358 / 20, name: "Ciudad\ndel Este"}, // Ciudad del Este convicted
      {long: -54.616667, lat: -25.516667, group: "D",  size: 1304 / 20, name: "Ciudad\ndel Este"} // Ciudad del Este total
    ];

  // var markers = [
  //   {N: 1, group: "A", pretrial: 1726, convicted: 1121, total: 2847, Prison: "Nacional",	OfficialCapacity: 1530, lat:	-25.30843282, long:	-57.64883203},
  //   {N: 2, group: "A", pretrial: NA, convicted: 245, total: 245, Prison: "Esperanza",	OfficialCapacity: 288, lat:	-25.30957652, long:	-57.6482776},
  //   {N: 3, group: "A", pretrial: NA, convicted: 29,	total: 29, Prison: "Granja Koe Kyaho",	OfficialCapacity: 13, lat:	-25.31051259, long:	-57.64790821},
  //   {N: 4, group: "A", pretrial: 1203, convicted: 308, total: 1511,	Prison: "Emboscada",	OfficialCapacity: 408, lat:	-25.09756272, long:	-57.31372471},
  //   {N: 5, group: "A", pretrial: 726, convicted: 688, total: 1414,	Prison: "Padre Juan A. de la Vega",	OfficialCapacity: 720, lat:	NA, long:	NA},
  //   {N: 6, group: "A", pretrial: 0, convicted: 12, total: 12, Prison: "Granja Ita Pora",	OfficialCapacity: 48, lat:	NA, long:	NA},
  //   {N: 7, group: "A", pretrial: 1034, convicted: 436, total: 1470,	Prison: "Ciudad del Este",	OfficialCapacity: 700, lat:	-25.52185188, long:	-54.61558444},
  //   {N: 8, group: "A", pretrial: 1111, convicted: 313, total: 1424,	Prison: "Encarnacion",	OfficialCapacity: 939, lat:	-27.31250453, long:	-55.80237282},
  //   {N: 9, group: "A", pretrial: 1001, convicted: 411, total: 1412,	Prison: "Misiones",	OfficialCapacity: 920, lat:	-26.69293657, long:	-57.0748426},
  //   {N: 10, group: "A", pretrial: 1051, convicted: 520,	total: 1571,	Prison: "CNEL. Oviedo",	OfficialCapacity: 960, lat:	-25.53694568, long:	-56.45939972},
  //   {N: 11, group: "A", pretrial: 337, convicted: 78, total: 415,	Prison: "Villarrica",	OfficialCapacity: 290, lat:	-25.78473681, long:	-56.43262025},
  //   {N: 12, group: "A", pretrial: 847, convicted: 339, total: 1086,	Prison: "Pedro J. Caballero",	OfficialCapacity: 930, lat:	-22.56869331, long:	-55.75819843},
  //   {N: 13, group: "A", pretrial: 994, convicted: 430, total: 1424,	Prison: "Concepción",	OfficialCapacity: 889, lat:	-23.40739422, long:	-57.38532142},
  //   {N: 14, group: "A", pretrial: 798, convicted: 347, total: 1145,	Prison: "San Pedro",	OfficialCapacity: 696, lat:	-24.08896588, long:	-57.0926787},
  //   {N: 15, group: "A", pretrial: NA,	convicted: NA,	total: NA,	Prison: "Buen Pastor",	OfficialCapacity: 470, lat:	-25.29000837, long:	-57.59107748},
  //   {N: 16, group: "A", pretrial: NA,	convicted: NA,	total: NA,	Prison: "Nuvea Oportunidad",	OfficialCapacity: 20, lat:	-25.29040407, long:	-57.59196852},
  //   {N: 17, group: "A", pretrial: NA,	convicted: NA,	total: NA,	Prison: "Serafina Dávalos",	OfficialCapacity: 62, lat:	NA, long:	NA},
  //   {N: 18, group: "A", pretrial: NA,	convicted: NA,	total: NA,	Prison: "Juana Maria de Lara",	OfficialCapacity: 102, lat:	NA, long:	NA},
  //   {N: 19, group: "A", pretrial: 10828, convicted: 5277,	total: 16105, Prison:	"Total", OfficialCapacity:9985, lat: NA, long: NA}
  // ];
    
    // Load external data and boot
    d3.json("https://raw.githubusercontent.com/holtzy/D3-graph-gallery/master/DATA/world.geojson", function(data){
    
        // Filter data
        data.features = data.features.filter( function(d){return d.properties.name=="Paraguay"} )
    
        // Create a color scale
        var color = d3.scaleOrdinal()
          .domain(["A", "B", "C" ])
          .range([ "#402D54", "#D18975", "#8FD175", "#A71103"])
    
        // Add a scale for bubble size
        var size = d3.scaleLinear()
          .domain([1,100])  // What's in the data
          .range([ 4, 50])  // Size in pixel
    
        // Draw the map
        svg.append("g")
            .selectAll("path")
            .data(data.features)
            .enter()
            .append("path")
              .attr("fill", "#b8b8b8")
              .attr("d", d3.geoPath()
                  .projection(projection)
              )
            .style("stroke", "black")
            .style("opacity", .3)
    
        // Add circles:
        // svg
        //   .selectAll("myCircles")
        //   .data(markers)
        //   .enter()
        //   .append("circle")
        //     .attr("class" , function(d){ return d.group })
        //     .attr("cx", function(d){ return projection([d.long, d.lat])[0] })
        //     .attr("cy", function(d){ return projection([d.long, d.lat])[1] })
        //     .attr("r", function(d){ return size(d.size) })
        //     .style("fill", function(d){ return color(d.group) })
        //     .attr("stroke", function(d){ return color(d.group) })
        //     .attr("stroke-width", 3)
        //     .attr("fill-opacity", .4)

        svg
          .selectAll("myCircles")
          .data(markers)
          .enter()
          .append("circle")
            .attr("class" , function(d){ return d.group })
            .attr("cx", function(d){ return projection([d.long, d.lat])[0] })
            .attr("cy", function(d){ return projection([d.long, d.lat])[1] })
            .attr("r", function(d){ return size(d.size) })
            .style("fill", function(d){ return color(d.group) })
            .attr("stroke", function(d){ return color(d.group) })
            .attr("stroke-width", 3)
            .attr("fill-opacity", .4)
        

        // This function is gonna change the opacity and size of selected and unselected circles
        function updateCapacities(){
    
          // For each check box:
          d3.selectAll("#capacities").each(function(d){
            cb = d3.select(this);
            grp = cb.property("value")
    
            // If the box is check, I show the group
            if(cb.property("checked")){
              svg.selectAll("."+grp).transition().duration(1000).style("opacity", 1).attr("r", function(d){ return size(d.size) })
    
            // Otherwise I hide it
            }else{
              svg.selectAll("."+grp).transition().duration(1000).style("opacity", 0).attr("r", 0)
            }
          })
        }
        // When a button change, I run the update function
        //d3.selectAll("#prisonbox").on("change",updatePrisons);
        d3.selectAll("#capacities").on("change",updateCapacities);
    
        // And I initialize it at the beginning
        update()
    })
    