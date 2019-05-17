import React, { useRef, useEffect, useContext } from "react";
import ChartJS from "chart.js";
import { data } from "./data";

ChartJS.defaults.global.elements.line.borderWidth = 1;
ChartJS.defaults.global.elements.point.radius = 0;

function Chart() {
  const chartEl = useRef(null);
  const myChart = useRef(null);
  useEffect(() => {
    myChart.current = new ChartJS(chartEl.current, {
      type: "line",
      data: {
        datasets: data.reactions
      },
      options: {
        maintainAspectRatio: false,
        scales: {
          xAxes: [
            {
              type: "time",
              time: {
                unit: "day"
              },
              gridLines: {
                drawOnChartArea: false
              },
              ticks: {
                padding: 20
              }
            }
          ],
          yAxes: [
            {
              ticks: {
                min: 0,
                max: 10,
                padding: 20
              },
              gridLines: {
                drawOnChartArea: false
              }
            }
          ]
        },
        legend: {
          // display: false
        }
      }
    });
  });

  return (
    <div style={{ height: "250px" }}>
      <canvas id="chart" ref={chartEl} />
    </div>
  );
}

export default Chart;
