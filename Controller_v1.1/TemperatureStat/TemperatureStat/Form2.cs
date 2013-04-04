using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace TemperatureStat
{
    public partial class Form2 : Form
    {
        Device _devs ;
        public Form2() 
        {

            InitializeComponent();
           
        }
        public void DevsSet(Device des)
        {
            _devs= des;
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            BuildGraph();
            timer1.Interval = 30000;
        }

        private void BuildGraph()
        {
            string[] seriesArray = { "Therm1", "Therm2", "Therm3", "Therm4" };


            // Set palette.
            // this.chart1.Palette = ChartColorPalette.SeaGreen;

            // Set title.
            this.chart1.Titles.Clear();
            this.chart1.Titles.Add("Themperature");
            this.chart1.Series.Clear();
            // Add series.
            Random rand = new Random();
            for (var i = 0; i < _devs.ThermometerCounter; i++)
            {
                // Add series.
                Series series = this.chart1.Series.Add(seriesArray[i]);
                series.ChartType = SeriesChartType.Line;
                // Add point.
                int counter = 0;
                if (i == 0)
                {
                    counter = _devs.temp1.Count;
                }
                else if (i == 1)
                {
                    counter = _devs.temp2.Count;
                }
                for (var j = 0; j < counter; j++)
                {
                    if (i == 0)
                    {
                        series.Points.Add(Convert.ToDouble(_devs.temp1[j]));
                    }
                    else if (i == 1)
                    {
                        series.Points.Add(Convert.ToDouble(_devs.temp2[j]));
                    }

                }

            }
        }

        private void Form2_Load(object sender, EventArgs e)
        {
            timer1.Interval = 500;
            chart1.ChartAreas.Add("themp");
            chart1.ChartAreas["themp"].AxisX.Minimum = 0;
            chart1.ChartAreas["themp"].AxisX.Interval = 60;
            chart1.ChartAreas["themp"].AxisY.Minimum = 0;
            chart1.ChartAreas["themp"].AxisY.Maximum = 70;
            chart1.ChartAreas["themp"].AxisY.Interval = 5;
        }

        private void button10_Click(object sender, EventArgs e)
        {

        }

        private void chart1_Click(object sender, EventArgs e)
        {

        }
    }
}
