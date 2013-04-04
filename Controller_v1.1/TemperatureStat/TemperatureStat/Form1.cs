using System;
using System.Globalization;
using System.IO;
using System.IO.Ports;              //  for get all aviables COM ports in OS
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

using System.Threading;
using Ini;

using System.Collections;

namespace TemperatureStat
{
    public partial class Form1 : Form
    {
        bool ComStatus;
        int update_time;
        int update_time_real;
        int clear;
        int clear_real;


        private String _logFileName = "";

        //Thread demoThread;
        String str_data = "";//new String;;
        
        double[] MAX_TEMP = new double[8];
        double[] MIN_TEMP = new double[8];
        bool test_check = false;
        bool test_check_prev = false;



        Device dev = new Device();

        IniFile settings;// = new IniFile("E:\\settings.ini");

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            DateTime saveNow = DateTime.Now;
            _logFileName = saveNow.ToString();
            _logFileName = _logFileName.Replace(":", "-");
            _logFileName = _logFileName + "_-_tempLOG.txt";
           // MessageBox.Show(_logFileName);

            String sysPath = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().GetName().CodeBase);
           
            settings = new IniFile("d:\\settings.ini");
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
            update_time = 60 * 1;
            update_time_real = update_time;
            clear = 300;
            clear_real = clear;
            txtTimeGetTemperature.Text = update_time.ToString();
            dev.ThermometerCounter = 0;
            textBox2.Text = settings.IniReadValue("LastCommands", "LastCommandSent");
            String ComPortValue = settings.IniReadValue("settings", "comPort");
           // MessageBox.Show(ComPortValue);
            if (ComPortValue.Length > 0)
            {
                //Int32 pos = comboBox1.FindStringExact(ComPortValue);
                comboBox1.SelectedIndex = comboBox1.FindStringExact(ComPortValue); ;
            }
        }

        private void cmdConnect_Click(object sender, EventArgs e)
        {
            //  Check if we have selected open port
            if (!ComStatus)
            {
                test_check = false;
                // Vot ne pomnu che eto za proverka
                // a nu eto toje pohojaya proverka
                if (comboBox1.SelectedIndex >= 0)
                {
                    //  Set port number
                    SerialPort1.PortName = comboBox1.SelectedItem.ToString();
                    settings.IniWriteValue("settings","comPort", comboBox1.SelectedItem.ToString());
                    SerialPort1.Open(); //  OPen port
                    ComStatus = true;   //  Set connected
                    //  Grafik poeben
                    cmdConnect.BackColor = System.Drawing.Color.Beige;
                    //cmdConnect.Text = "Выкл";
                    timer3.Enabled = true;
                    timer4.Enabled = true;
                }
                else
                {
                    //  If not selected any com port  GO to selection one of them
                    comboBox1.Focus();
                    comboBox1.DroppedDown = true;
                }

            }
            else
            {
                //  Close the connection
                ComStatus = false;
                test_check = false;
                timer3.Enabled = false;
                timer4.Enabled = false;
                try
                {
                    SerialPort1.Close();    
                }
                catch(Exception ex)
                {
                    textBox1.Text = "Disconect error:" + ex.Message.ToString() + Environment.NewLine + this.textBox1.Text;
                }
                

                cmdConnect.BackColor = System.Drawing.Color.Lime;
                //cmdConnect.Text = "Вкл";    //  Change button description
            }    
        }


        private void SerialPort1_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            try
            {
                str_data = SerialPort1.ReadLine();// builder.ToString(); 
                textBox4.Text = str_data;
            }
            catch(Exception ex)
            {
               // textBox1.Text = "RX error:" + ex.Message.ToString() + Environment.NewLine + this.textBox1.Text;
            }
            

        }

        private void cmdSendData_Click(object sender, EventArgs e)
        {
            settings.IniWriteValue("LastCommands", "LastCommandSent",textBox2.Text);
            SendCommand(textBox2.Text);
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if (str_data.Length > 0)
            {
                this.textBox1.Text = "Rx:" + str_data + Environment.NewLine + this.textBox1.Text;

              //  try
             //   {

                    if (str_data.Length >=3 && str_data.Substring(0, 3) == "TC:")
                    {
                        dev.ThermometerCounter = Convert.ToInt32(str_data.Substring(3));
                    }
                    else if (str_data.Length >=3 && str_data.Substring(0, 3) == "TM:")
                    {
                        lblTime.Text = str_data.Substring(3);
                    }
                    else if (str_data.Length >=4 && str_data.Substring(0, 4) == "STOP")
                    {
                        //cmdConnect.BackColor = System.Drawing.Color.Beige;
                        timer4.Enabled = false;
                    }
                    else if (str_data.Length >= 5 && str_data.Substring(0, 5) == "START")
                    {
                        //cmdConnect.BackColor = System.Drawing.Color.Red;
                        timer4.Enabled = true;
                    }
                    else if (str_data.Length >= 4 && str_data.Substring(0, 4) == "STPR")
                    {
                        char prec = str_data.Substring(4)[0];
                        lblControllerTimePrecision.Text = ((Int32)prec).ToString(CultureInfo.InvariantCulture);
                    }
                    else if (str_data.Length >= 10 && str_data.Substring(0, 10) == "DAYNUMBER:")
                    {
                       // char daynumber = str_data.Substring(10)[0];
                        lblDayNumber.Text = "День " + Convert.ToInt32(str_data.Substring(10)) + "-ый";
                    }
                    else if (str_data.Length >= 10 && str_data.Substring(0, 10) == "TEST:Good.")
                    {
                        test_check = true;
                        cmdConnect.BackColor = System.Drawing.Color.Red;
                        lblT01.BackColor = System.Drawing.Color.Black;
                        lblT02.BackColor = System.Drawing.Color.Black;
                    }
                    else if (str_data.Length >= 5 && str_data.Substring(0, 5) == "T[0]:")
                    {
                        lblT01.Text = (str_data.Substring(5));
                        String temp = lblT01.Text;

                        double temp01 = Convert.ToDouble(temp.Replace('.', ','));
                        temp01 = CheckTemperatureDomain(temp01);
                        dev.temp1.Add(temp01);
                        WriteTemperatureToFile(temp01.ToString(), 1);
                        if (MIN_TEMP[0] == 0 && MAX_TEMP[0] == 0)
                        {
                            MIN_TEMP[0] = temp01;
                            MAX_TEMP[0] = temp01;
                        }
                        MIN_TEMP[0] = Math.Min(temp01, MIN_TEMP[0]);
                        MAX_TEMP[0] = Math.Max(temp01, MAX_TEMP[0]);
                        lblmin01.Text = MIN_TEMP[0].ToString(CultureInfo.InvariantCulture);
                        lblmax01.Text = MAX_TEMP[0].ToString(CultureInfo.InvariantCulture); 
                    }
                    else if (str_data.Length >= 5 && str_data.Substring(0, 5) == "T[1]:")
                    {
                        lblT02.Text = (str_data.Substring(5));
                        String temp = lblT02.Text;

                        double temp02 = Convert.ToDouble(temp.Replace('.', ','));
                        temp02 = CheckTemperatureDomain(temp02);
                        dev.temp2.Add(temp02);
                        WriteTemperatureToFile(temp02.ToString(), 2);
                        if (MIN_TEMP[1] == 0 && MAX_TEMP[1] == 0)
                        {
                            MIN_TEMP[1] = temp02;
                            MAX_TEMP[1] = temp02;
                        }
                        MIN_TEMP[1] = Math.Min(temp02, MIN_TEMP[1]);
                        MAX_TEMP[1] = Math.Max(temp02, MAX_TEMP[1]);

                        lblmin02.Text = MIN_TEMP[1].ToString();
                        lblmax02.Text = MAX_TEMP[1].ToString();
                    }
                    else if(str_data.Length >=6 )
                    {
                        switch (str_data.Substring(0, 6))
                        {
                            case "PERIOD":
                                lblPeriod.Text = "Период : " + str_data.Substring(7)[0];
                                break;
                            case "DAY.ST":
                                lblDeviceDayStartTime.Text = "начало дня: " + (Int32)str_data.Substring(7)[0];
                                break;
                            case "PER.A.":
                                lblPeriodALen.Text = "Per A len: " + (Int32)str_data.Substring(7)[0];
                                break;
                            case "PER.B.":
                                lblPeriodBLen.Text = "Per B len: " + (Int32)str_data.Substring(7)[0];
                                break;
                            case "GETOPS":
                                label10.Text = "Обдув:" + str_data.Substring(7)[0] + " Выдув:"+ str_data.Substring(8)[0] + " Свет:" + str_data.Substring(9)[0];
                                break;
                             
                        }
                    }
                //}
               // catch(Exception ex)
              //  {
              //      textBox1.Text = ex.Message.ToString() + " - Mess:" + str_data + Environment.NewLine + this.textBox1.Text; ;
              //  }

            }
            str_data = ""; 
            lblUpdateTime.Text = update_time_real.ToString() + " / " + update_time.ToString();
            txtThermometerCounter.Text = dev.ThermometerCounter.ToString();
        }
        public double CheckTemperatureDomain(double value)
        {
            if (value < -50 || value > 150)
            {
                return( 0);
            }
            return (value);

        }
        private void timer2_Tick(object sender, EventArgs e)
        {
            lblSystemTime.Text = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString() + ":" + DateTime.Now.Second.ToString();

            if (ComStatus )
            {
                if (test_check == test_check_prev && test_check == false)
                {
                    dev.Connect();
                }
                else if (test_check == true && test_check_prev == false)
                {
                    dev.ThermometerCount();
                    dev.getThermometersID();
                    dev.getTemperature();
                    dev.getTime();
                    dev.getTimePrecision();
                    dev.getPeriod();
                    dev.getDayStart();
                    dev.getPeriodALen();
                    dev.getPeriodBLen();
                    dev.getDayNumber();
                    dev.getOutputStatus();
                }
                Int32 mins = Convert.ToInt32(DateTime.Now.Minute.ToString());

                test_check_prev = test_check;
                update_time_real--;
                if (update_time_real < 0)
                {
                    update_time_real = update_time;
                    SendCommand("GT");
                }

                clear_real--;
                if (clear_real < 0)
                {
                    textBox1.Text = "Auto Cleared.....";
                    clear_real = clear;
                }
            }

        }

        private void cmdTimeGetTemperatureSet_Click_1(object sender, EventArgs e)
        {
            int temp = update_time - update_time_real;
            try
            {
                update_time = Convert.ToInt32(txtTimeGetTemperature.Text);
                if (update_time < 1)
                {
                    update_time = 2;
                }
            }
            catch (Exception )
            {
                update_time = 300;
            }

            update_time_real = update_time - temp;
        }

        private void listBox1_DoubleClick(object sender, EventArgs e)
        {
            String Command = (string)listBox1.SelectedItem;
            textBox2.Text = Command.Substring(0, Command.IndexOf(' '));
        }

        private void button3_Click(object sender, EventArgs e)
        {
            textBox1.Text = "Cleared..........";
        }

        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                clear = Convert.ToInt32(lblClearTime.Text);
                if (clear < 3)
                {
                    clear = 3;
                }
            }
            catch (Exception)
            {
                clear_real = 300;
            }
            clear_real = clear;
        }



        private void UpdateTime(String TimeParameter, String value)
        {
             Int32 timeToUpdate = Convert.ToInt32(value);
             SendCommand("TU" + TimeParameter + (char)timeToUpdate);
        }
        public void SendCommand(String command)
        {
            if (ComStatus)
            {
                dev.SendData(command);
                //SerialPort1.Write(command);
               // textBox1.Text = "Sent: " + command + Environment.NewLine + this.textBox1.Text;
            }
          //  else
               // textBox1.Text = "Cannot send:: " + command + Environment.NewLine + this.textBox1.Text;
        }


        private void button8_Click(object sender, EventArgs e)
        {

            dev.UpdateTime();
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if(ComStatus)
            {
                try
                {
                    SerialPort1.Close();    
                }
                catch(Exception ex)
                {
                    textBox1.Text = "Close error:" + ex.Message.ToString() + Environment.NewLine + this.textBox1.Text;
                }
                
            }
                
        }

        private void button9_Click(object sender, EventArgs e)
        {
            if (txtTimeSetForTimer.Text.Length > 0)
            {
                Int32 timeToUpdate = Convert.ToInt32(txtTimeSetForTimer.Text);
                SendCommand("TC" + (char)timeToUpdate);
            }
        }


        private void button10_Click(object sender, EventArgs e)
        {
            Form2 form2 = new Form2();
            form2.Show();
            form2.DevsSet (dev);
        }

        private void timer3_Tick(object sender, EventArgs e)
        {
            dev.getTime();
        }

        private void button11_Click(object sender, EventArgs e)
        {
            dev.EanbleObduv();
        }

        private void button18_Click(object sender, EventArgs e)
        {
            dev.EanbleViduv();
        }

        private void button14_Click(object sender, EventArgs e)
        {
            dev.EanbleLight();
        }

        private void button12_Click(object sender, EventArgs e)
        {
            dev.DisableObduv();
        }

        private void button17_Click(object sender, EventArgs e)
        {
            dev.DisableViduv();
        }

        private void button13_Click(object sender, EventArgs e)
        {
            dev.DisableLight();
        }
            

        private void button15_Click(object sender, EventArgs e)
        {
            Int32 dayStart = Convert.ToInt32(txtDayStart.Text);
            if (dayStart >= 0 && dayStart<=23)
            {
                dev.setDayStart(dayStart);
            }

            else
            {
                MessageBox.Show("Day start time incorect! : [0-23]");
            }
        }

        private void button19_Click(object sender, EventArgs e)
        {
            dev.setPeriod(Device.Period.PERIOD_18_6); 
        }

        private void button16_Click(object sender, EventArgs e)
        {
            dev.setPeriod(Device.Period.PERIOD_12_12);
        }

        private void button20_Click(object sender, EventArgs e)
        {
            dev.getPeriod();   
        }
        
        private void timer4_Tick(object sender, EventArgs e)
        {
            if(dev.ifHaveCommandToSend())
            {
                String str = "";
                if (ComStatus)
                {
                    str = dev.GetCommand();
                    if (str.Length > 0)
                    {
                        try
                        {
                            SerialPort1.Write(str);
                            if (str != "TM")
                                textBox1.Text = "Sent: " + str + Environment.NewLine + this.textBox1.Text;
                        }
                        catch(Exception ex)
                        {
                            textBox1.Text = "Write error:" + ex.Message.ToString() + Environment.NewLine + this.textBox1.Text;
                        }
                        

                    }
                }
                // else
                // textBox1.Text = "-Cannot send:: " + str + Environment.NewLine + this.textBox1.Text;               
            }

        }

        private void btnPeriodAset_Click(object sender, EventArgs e)
        {
            dev.setPeriodALen(txtPeriodAset.Text);
        }

        private void btnPeriodBset_Click(object sender, EventArgs e)
        {
            dev.setPeriodBLen(txtPeriodBset.Text);
        }

        private void btnCheckTemperature_Click(object sender, EventArgs e)
        {
            dev.getTemperature();
        }

        private void btnCheckTime_Click(object sender, EventArgs e)
        {
            dev.getTime();
        }

        private void lblPeriodALen_Click(object sender, EventArgs e)
        {

        }

        private void btnGetDayNumber_Click(object sender, EventArgs e)
        {
            dev.getDayNumber();
        }

        private void btnGetOutputStatus_Click(object sender, EventArgs e)
        {
            dev.getOutputStatus();
        }

        private void tmrUpdateDayAndOutput_Tick(object sender, EventArgs e)
        {
            dev.getDayNumber();
            dev.getOutputStatus();
        }

        private void button1_Click(object sender, EventArgs e)
        {
           
        }

        private void btnLockControl_Click(object sender, EventArgs e)
        {
            dev.getLockOnControl();
        }

        private void btnUnlockControl_Click(object sender, EventArgs e)
        {
            dev.getUnLockOnControl();
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            dev.getAgresiveTemperature();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            dev.getTemperature();
        }

        private void panel6_Paint(object sender, PaintEventArgs e)
        {

        }


        private void WriteTemperatureToFile(String temp, Int32 thermomterID)
        {

            // create a writer and open the file
            TextWriter tw = new StreamWriter(Path.GetDirectoryName(Application.ExecutablePath) + "\\" + _logFileName,true);

            // write a line of text to the file
            tw.WriteLine(DateTime.Now + "#" + thermomterID + "#" + temp);

            // close the stream
            tw.Close();
        }

 
    }
}
