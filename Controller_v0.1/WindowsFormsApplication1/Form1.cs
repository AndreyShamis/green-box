using System;
using System.IO;
using System.IO.Ports;              //  for get all aviables COM ports in OS
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        bool ComStatus;
        


        struct _DeviceState
        {
            private bool _light;
            private bool _fan_obduv;
            private bool _fan_viduv;
            private int _temp_counter;
            private int _status_a;
            private int _status_b;

            public int statusA
            {
                get
                {
                    return _status_a;
                }
                set
                {
                    _status_a = value;
                }
            }
            public int statusB
            {
                get
                {
                    return _status_b;
                }
                set
                {
                    _status_b = value;
                }
            }

            public bool light
            {
                get
                {
                    return _light;
                }
                set
                {
                    _light = value;
                }
            }
            public bool fan_obduv
            {
                get
                {
                    return _fan_obduv;
                }
                set
                {
                    _fan_obduv = value;
                }
            }
            public bool fan_viduv
            {
                get
                {
                    return _fan_viduv;
                }
                set
                {
                    _fan_viduv = value;
                }
            }
            public int temp_counter
            {
                get
                {
                    return _temp_counter;
                }
                set
                {
                    _temp_counter = value;
                }
            }
        };


        _DeviceState DeviceState;
        public Form1()
        {
            InitializeComponent();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {

            ComStatus = false; /// Variable to know if posible open connection by COM port
            // Get a list of serial port names.
            string[] ports = SerialPort.GetPortNames();
            //Int16 i;
            //for (i = 0; i < 10; i++)
            //{
            //    comboBox1.Items.Add("COM" + (i+1));
            //}

            // Display each port name to the combo box.
            foreach (string port in ports)
            {
                comboBox1.Items.Add(port);
                //Console.WriteLine
            }

            //Console.ReadLine();
    
        }
        /**
         * Function for open connection to device
         * */
        private void cmdConnect_Click(object sender, EventArgs e)
        {
            //  Check if we have selected open port
            if (!ComStatus)
            {
                // Vot ne pomnu che eto za proverka
                // a nu eto toje pohojaya proverka
                if (comboBox1.SelectedIndex >= 0)
                {
                    //  Set port number
                    serialPort1.PortName = comboBox1.SelectedItem.ToString();
                    serialPort1.Open(); //  OPen port
                    ComStatus = true;   //  Set connected
                    //  Grafik poeben
                    cmdConnect.BackColor = System.Drawing.Color.Red;
                    cmdConnect.Text = "Disconnect";
                }
                else
                {
                    //  If not selected any com port
                    //  GO to selection one of them
                    comboBox1.Focus();
                    comboBox1.DroppedDown = true;
                }
                
            }
            else
            {
                //  Close the connection
                serialPort1.Close();
                ComStatus = false;
                cmdConnect.BackColor = System.Drawing.Color.Lime;
                cmdConnect.Text = "Connect";    //  Change button description
            }          
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            DateTime dt = DateTime.Now;
            lblLoaclTime.Text = dt.Hour  + ":" + dt.Minute + ":" + dt.Second;

            label1.Text =  "Connection status: " + Convert.ToString(serialPort1.IsOpen);
            if (ComStatus)
            {
                textBox1.Enabled = true;
                if (String.Compare(lblLoaclTime.Text, lblDeviceTime.Text) != 0)
                {
                    lblDeviceTime.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    lblDeviceTime.ForeColor = System.Drawing.Color.Black ;
                }
                lblReceived.Text = serialPort1.BytesToRead.ToString();
                lblTransmited.Text = serialPort1.BytesToWrite.ToString();

                if (DeviceState.light == true)
                    lblLightStatus.BackColor  = System.Drawing.Color.LightGreen ;
                else
                    lblLightStatus.BackColor = System.Drawing.Color.Pink;
                if (DeviceState.fan_obduv == true)
                    lblFanObduv.BackColor = System.Drawing.Color.LightGreen;
                else
                    lblFanObduv.BackColor = System.Drawing.Color.Pink;
                if (DeviceState.fan_viduv  == true)
                    lblFanViduv.BackColor = System.Drawing.Color.LightGreen;
                else
                    lblFanViduv.BackColor = System.Drawing.Color.Pink;

                lblThrmCounter.Text = Convert.ToString(DeviceState.temp_counter);
            }
            else
            {
                textBox1.Enabled = false;
            }
            
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void listBox1_MouseClick(object sender, MouseEventArgs e)
        {
            
        }

        private void listBox1_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (ComStatus)
            {
                String command = listBox1.SelectedItem.ToString();


                if ("CM:W:TR" == command)
                {
                    DateTime dt = DateTime.Now;
                    command = command + ":" + dt.Hour + ":" + dt.Minute + ":" + dt.Second;
                }
                textBox1.Text = command;

                serialPort1.Write(textBox1.Text);
            }
        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void cmdClearT_Click(object sender, EventArgs e)
        {
            textBox1.Text = "";
        }

        private void cmdClearR_Click(object sender, EventArgs e)
        {
            textBox2.Text = "";
        }

        private void textBox1_KeyPress(object sender, KeyPressEventArgs e)
        {

        }

        private void textBox1_KeyUp(object sender, KeyEventArgs e)
        {
            String tempChar;
            String full = textBox1.Text;
            tempChar = full.Substring(full.Length - 1);
            serialPort1.Write(tempChar);
        }

        private void toolStripStatusLabel1_Click(object sender, EventArgs e)
        {

        }
        // Eto emulacia poluchenia comand ot bakara/
        private void button11_Click(object sender, EventArgs e)
        {
            String WillBeReturned = "";
            WillBeReturned = DeviceState.fan_obduv.ToString();
            textBox1.Text = WillBeReturned;
            String data = textBox3.Text;
            String temp = data.Substring(0, 3);
            if (string.Compare("AN:",temp)==0)
            {
                String ModuleName = data.Substring(3, 2);
                String ModuleValue = data.Substring(6);
                switch(ModuleName)
                {
                    case "LI":
                        if (String.Compare(ModuleValue, "0")==0)
                        {
                            DeviceState.light = false;
                        }
                        else
                            DeviceState.light = true;
                        break;
                    case "FO":
                        if (String.Compare(ModuleValue, "0") == 0)
                        {
                            DeviceState.fan_obduv = false;
                        }
                        else
                            DeviceState.fan_obduv = true;
                        break;
                    case "FV":
                        if (String.Compare(ModuleValue, "0") == 0)
                        {
                            DeviceState.fan_viduv = false;
                        }
                        else
                            DeviceState.fan_viduv = true;
                        break;
                    case "TC":
                        DeviceState.temp_counter = Convert.ToInt16(ModuleValue);
                        break;

                }
                Console.WriteLine("Mod Name: " + ModuleName + "\t\t Mod Value: " + ModuleValue);

            }
        }

        private void button12_Click(object sender, EventArgs e)
        {
            byte[] b = new byte[1024];
            UTF8Encoding temp = new UTF8Encoding(true);
            char []data = new char[20];

            int i = 0;
            FileStream fileStream = new FileStream(@"E:\Dropbox\qp_workspace\greenhouse\myfile.txt", FileMode.Open, FileAccess.ReadWrite);
            while (fileStream.Read(b, 0, b.Length) > 0) ;
            fileStream.Close();

            textBox1.Text = ((int)b[0]).ToString() + ":"
                + ((int)b[1]).ToString() + ":"
                + ((int)b[2]).ToString() + ":"
                + ((int)b[3]).ToString() + ":" 
                + (b[4].ToString());

            bool dev_error = false;
            if (b[0] == 2)
            {
                if (b[1] == 1)
                    DeviceState.light = true;
                else if (b[1] == 2)
                    DeviceState.light = false;
                else
                    dev_error = true;

                if (b[2] == 1)
                    DeviceState.fan_obduv = true;
                else if (b[2] == 2)
                    DeviceState.fan_obduv = false;
                else
                    dev_error = true;

                if (b[3] == 1)
                    DeviceState.fan_viduv = true;
                else if (b[3] == 2)
                    DeviceState.fan_viduv = false;
                else
                    dev_error = true;

                if (b[4] == 'd')
                    DeviceState.statusA = 1;
                else if (b[3] == 'n')
                    DeviceState.statusA = 2;
                else
                    dev_error = true;

                if (b[5] == 'v')
                    DeviceState.statusB = 1;
                else if (b[3] == 'f')
                    DeviceState.statusB = 2;
                else
                    dev_error = true;
            }

        }


    }
}
