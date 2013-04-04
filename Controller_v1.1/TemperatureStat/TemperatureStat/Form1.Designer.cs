namespace TemperatureStat
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.SerialPort1 = new System.IO.Ports.SerialPort(this.components);
            this.cmdConnect = new System.Windows.Forms.Button();
            this.comboBox1 = new System.Windows.Forms.ComboBox();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.cmdSendData = new System.Windows.Forms.Button();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.timer2 = new System.Windows.Forms.Timer(this.components);
            this.txtThermometerCounter = new System.Windows.Forms.TextBox();
            this.listBox1 = new System.Windows.Forms.ListBox();
            this.lblT01 = new System.Windows.Forms.Label();
            this.lblT02 = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.button4 = new System.Windows.Forms.Button();
            this.btnGetOutputStatus = new System.Windows.Forms.Button();
            this.lblClearTime = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.cmdTimeGetTemperatureSet = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.txtTimeGetTemperature = new System.Windows.Forms.TextBox();
            this.btnCheckTime = new System.Windows.Forms.Button();
            this.btnCheckTemperature = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.lblmin01 = new System.Windows.Forms.Label();
            this.lblmax01 = new System.Windows.Forms.Label();
            this.lblmax02 = new System.Windows.Forms.Label();
            this.lblmin02 = new System.Windows.Forms.Label();
            this.lblTime = new System.Windows.Forms.Label();
            this.button8 = new System.Windows.Forms.Button();
            this.lblSystemTime = new System.Windows.Forms.Label();
            this.txtTimeSetForTimer = new System.Windows.Forms.TextBox();
            this.button9 = new System.Windows.Forms.Button();
            this.lblControllerTimePrecision = new System.Windows.Forms.Label();
            this.textBox3 = new System.Windows.Forms.TextBox();
            this.button10 = new System.Windows.Forms.Button();
            this.timer3 = new System.Windows.Forms.Timer(this.components);
            this.button11 = new System.Windows.Forms.Button();
            this.button12 = new System.Windows.Forms.Button();
            this.button17 = new System.Windows.Forms.Button();
            this.button18 = new System.Windows.Forms.Button();
            this.button13 = new System.Windows.Forms.Button();
            this.button14 = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.txtDayStart = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.button15 = new System.Windows.Forms.Button();
            this.button16 = new System.Windows.Forms.Button();
            this.button19 = new System.Windows.Forms.Button();
            this.button20 = new System.Windows.Forms.Button();
            this.timer4 = new System.Windows.Forms.Timer(this.components);
            this.lblDeviceDayStartTime = new System.Windows.Forms.Label();
            this.txtPeriodAset = new System.Windows.Forms.TextBox();
            this.txtPeriodBset = new System.Windows.Forms.TextBox();
            this.btnPeriodAset = new System.Windows.Forms.Button();
            this.btnPeriodBset = new System.Windows.Forms.Button();
            this.label10 = new System.Windows.Forms.Label();
            this.btnGetDayNumber = new System.Windows.Forms.Button();
            this.lblDayNumber = new System.Windows.Forms.Label();
            this.tmrUpdateDayAndOutput = new System.Windows.Forms.Timer(this.components);
            this.lblUpdateTime = new System.Windows.Forms.Label();
            this.panel2 = new System.Windows.Forms.Panel();
            this.panel3 = new System.Windows.Forms.Panel();
            this.lblPeriod = new System.Windows.Forms.Label();
            this.btnLockControl = new System.Windows.Forms.Button();
            this.btnUnlockControl = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.panel4 = new System.Windows.Forms.Panel();
            this.panel5 = new System.Windows.Forms.Panel();
            this.lblPeriodALen = new System.Windows.Forms.Label();
            this.lblPeriodBLen = new System.Windows.Forms.Label();
            this.panel6 = new System.Windows.Forms.Panel();
            this.textBox4 = new System.Windows.Forms.TextBox();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            this.panel3.SuspendLayout();
            this.panel4.SuspendLayout();
            this.panel5.SuspendLayout();
            this.panel6.SuspendLayout();
            this.SuspendLayout();
            // 
            // SerialPort1
            // 
            this.SerialPort1.WriteTimeout = 800;
            this.SerialPort1.DataReceived += new System.IO.Ports.SerialDataReceivedEventHandler(this.SerialPort1_DataReceived);
            // 
            // cmdConnect
            // 
            this.cmdConnect.BackColor = System.Drawing.Color.White;
            this.cmdConnect.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.cmdConnect.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.cmdConnect.ForeColor = System.Drawing.Color.White;
            this.cmdConnect.Image = ((System.Drawing.Image)(resources.GetObject("cmdConnect.Image")));
            this.cmdConnect.Location = new System.Drawing.Point(529, 5);
            this.cmdConnect.Name = "cmdConnect";
            this.cmdConnect.Size = new System.Drawing.Size(30, 30);
            this.cmdConnect.TabIndex = 5;
            this.cmdConnect.UseVisualStyleBackColor = false;
            this.cmdConnect.Click += new System.EventHandler(this.cmdConnect_Click);
            // 
            // comboBox1
            // 
            this.comboBox1.DisplayMember = "1";
            this.comboBox1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox1.FormattingEnabled = true;
            this.comboBox1.Location = new System.Drawing.Point(565, 15);
            this.comboBox1.Name = "comboBox1";
            this.comboBox1.Size = new System.Drawing.Size(68, 21);
            this.comboBox1.Sorted = true;
            this.comboBox1.TabIndex = 4;
            // 
            // textBox1
            // 
            this.textBox1.BackColor = System.Drawing.Color.LightGray;
            this.textBox1.Location = new System.Drawing.Point(164, 29);
            this.textBox1.Multiline = true;
            this.textBox1.Name = "textBox1";
            this.textBox1.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.textBox1.Size = new System.Drawing.Size(162, 316);
            this.textBox1.TabIndex = 6;
            // 
            // cmdSendData
            // 
            this.cmdSendData.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.cmdSendData.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(0)))));
            this.cmdSendData.Location = new System.Drawing.Point(164, 9);
            this.cmdSendData.Name = "cmdSendData";
            this.cmdSendData.Size = new System.Drawing.Size(26, 19);
            this.cmdSendData.TabIndex = 7;
            this.cmdSendData.Text = "Ok";
            this.cmdSendData.UseVisualStyleBackColor = true;
            this.cmdSendData.Click += new System.EventHandler(this.cmdSendData_Click);
            // 
            // textBox2
            // 
            this.textBox2.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.textBox2.ForeColor = System.Drawing.Color.LimeGreen;
            this.textBox2.Location = new System.Drawing.Point(3, 9);
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new System.Drawing.Size(162, 19);
            this.textBox2.TabIndex = 8;
            this.textBox2.Text = "GT";
            // 
            // timer1
            // 
            this.timer1.Enabled = true;
            this.timer1.Interval = 10;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // timer2
            // 
            this.timer2.Enabled = true;
            this.timer2.Interval = 1000;
            this.timer2.Tick += new System.EventHandler(this.timer2_Tick);
            // 
            // txtThermometerCounter
            // 
            this.txtThermometerCounter.BackColor = System.Drawing.Color.LightGray;
            this.txtThermometerCounter.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.txtThermometerCounter.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.txtThermometerCounter.Location = new System.Drawing.Point(6, 344);
            this.txtThermometerCounter.Name = "txtThermometerCounter";
            this.txtThermometerCounter.Size = new System.Drawing.Size(28, 16);
            this.txtThermometerCounter.TabIndex = 16;
            this.txtThermometerCounter.Text = "0";
            this.txtThermometerCounter.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // listBox1
            // 
            this.listBox1.BackColor = System.Drawing.SystemColors.InactiveCaption;
            this.listBox1.FormattingEnabled = true;
            this.listBox1.Items.AddRange(new object[] {
            "GT - Get Temperature",
            "TM - Get Time",
            "STPR - Send Time Precision",
            "THCO - Thermometers Count",
            "GETPER - Get period",
            "WRHRTOEP -write time to eeprom",
            "SD - Send Devices ID",
            "RT - Find Thermometers",
            " TU (H/M/S) Time Update",
            "TEST - Check",
            "ENOB - ",
            "ENVI - ",
            "ENLI - ",
            "DIOB -",
            "DIVI -",
            "DILI -"});
            this.listBox1.Location = new System.Drawing.Point(3, 29);
            this.listBox1.Name = "listBox1";
            this.listBox1.Size = new System.Drawing.Size(162, 316);
            this.listBox1.TabIndex = 17;
            this.listBox1.DoubleClick += new System.EventHandler(this.listBox1_DoubleClick);
            // 
            // lblT01
            // 
            this.lblT01.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.lblT01.Font = new System.Drawing.Font("Microsoft Sans Serif", 19.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblT01.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.lblT01.Location = new System.Drawing.Point(19, 0);
            this.lblT01.Name = "lblT01";
            this.lblT01.Size = new System.Drawing.Size(103, 33);
            this.lblT01.TabIndex = 19;
            this.lblT01.Text = "T01";
            this.lblT01.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblT02
            // 
            this.lblT02.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.lblT02.Font = new System.Drawing.Font("Microsoft Sans Serif", 19.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblT02.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.lblT02.Location = new System.Drawing.Point(19, -1);
            this.lblT02.Name = "lblT02";
            this.lblT02.Size = new System.Drawing.Size(103, 33);
            this.lblT02.TabIndex = 20;
            this.lblT02.Text = "T02";
            this.lblT02.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.button4);
            this.panel1.Controls.Add(this.btnGetOutputStatus);
            this.panel1.Controls.Add(this.lblClearTime);
            this.panel1.Controls.Add(this.label4);
            this.panel1.Controls.Add(this.cmdTimeGetTemperatureSet);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.txtTimeGetTemperature);
            this.panel1.Location = new System.Drawing.Point(6, 57);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(190, 113);
            this.panel1.TabIndex = 21;
            this.panel1.Tag = "";
            // 
            // button4
            // 
            this.button4.Location = new System.Drawing.Point(155, 23);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(32, 20);
            this.button4.TabIndex = 21;
            this.button4.Text = "Ok";
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // btnGetOutputStatus
            // 
            this.btnGetOutputStatus.Location = new System.Drawing.Point(4, 87);
            this.btnGetOutputStatus.Name = "btnGetOutputStatus";
            this.btnGetOutputStatus.Size = new System.Drawing.Size(131, 20);
            this.btnGetOutputStatus.TabIndex = 70;
            this.btnGetOutputStatus.Text = "]";
            this.btnGetOutputStatus.UseVisualStyleBackColor = true;
            this.btnGetOutputStatus.Click += new System.EventHandler(this.btnGetOutputStatus_Click);
            // 
            // lblClearTime
            // 
            this.lblClearTime.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblClearTime.Location = new System.Drawing.Point(85, 23);
            this.lblClearTime.Name = "lblClearTime";
            this.lblClearTime.Size = new System.Drawing.Size(71, 20);
            this.lblClearTime.TabIndex = 20;
            this.lblClearTime.Text = "300";
            this.lblClearTime.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label4.Location = new System.Drawing.Point(4, 23);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(63, 17);
            this.label4.TabIndex = 19;
            this.label4.Text = "Clean[s]:";
            // 
            // cmdTimeGetTemperatureSet
            // 
            this.cmdTimeGetTemperatureSet.Location = new System.Drawing.Point(155, 2);
            this.cmdTimeGetTemperatureSet.Name = "cmdTimeGetTemperatureSet";
            this.cmdTimeGetTemperatureSet.Size = new System.Drawing.Size(32, 20);
            this.cmdTimeGetTemperatureSet.TabIndex = 16;
            this.cmdTimeGetTemperatureSet.Text = "Ok";
            this.cmdTimeGetTemperatureSet.UseVisualStyleBackColor = true;
            this.cmdTimeGetTemperatureSet.Click += new System.EventHandler(this.cmdTimeGetTemperatureSet_Click_1);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label2.Location = new System.Drawing.Point(4, 3);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(77, 17);
            this.label2.TabIndex = 15;
            this.label2.Text = "Update[s] :";
            // 
            // txtTimeGetTemperature
            // 
            this.txtTimeGetTemperature.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.txtTimeGetTemperature.Location = new System.Drawing.Point(110, 2);
            this.txtTimeGetTemperature.Name = "txtTimeGetTemperature";
            this.txtTimeGetTemperature.Size = new System.Drawing.Size(45, 20);
            this.txtTimeGetTemperature.TabIndex = 14;
            this.txtTimeGetTemperature.Text = "30";
            this.txtTimeGetTemperature.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // btnCheckTime
            // 
            this.btnCheckTime.Image = ((System.Drawing.Image)(resources.GetObject("btnCheckTime.Image")));
            this.btnCheckTime.Location = new System.Drawing.Point(3, 4);
            this.btnCheckTime.Name = "btnCheckTime";
            this.btnCheckTime.Size = new System.Drawing.Size(18, 21);
            this.btnCheckTime.TabIndex = 67;
            this.btnCheckTime.UseVisualStyleBackColor = true;
            this.btnCheckTime.Click += new System.EventHandler(this.btnCheckTime_Click);
            // 
            // btnCheckTemperature
            // 
            this.btnCheckTemperature.Image = ((System.Drawing.Image)(resources.GetObject("btnCheckTemperature.Image")));
            this.btnCheckTemperature.Location = new System.Drawing.Point(0, 0);
            this.btnCheckTemperature.Name = "btnCheckTemperature";
            this.btnCheckTemperature.Size = new System.Drawing.Size(18, 20);
            this.btnCheckTemperature.TabIndex = 66;
            this.btnCheckTemperature.UseVisualStyleBackColor = true;
            this.btnCheckTemperature.Click += new System.EventHandler(this.btnCheckTemperature_Click);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(287, 2);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(37, 24);
            this.button3.TabIndex = 22;
            this.button3.Text = "Clear";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // lblmin01
            // 
            this.lblmin01.BackColor = System.Drawing.Color.DimGray;
            this.lblmin01.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblmin01.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.lblmin01.Location = new System.Drawing.Point(122, 17);
            this.lblmin01.Name = "lblmin01";
            this.lblmin01.Size = new System.Drawing.Size(52, 16);
            this.lblmin01.TabIndex = 23;
            this.lblmin01.Text = "min/max";
            // 
            // lblmax01
            // 
            this.lblmax01.BackColor = System.Drawing.Color.DimGray;
            this.lblmax01.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblmax01.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.lblmax01.Location = new System.Drawing.Point(122, 0);
            this.lblmax01.Name = "lblmax01";
            this.lblmax01.Size = new System.Drawing.Size(52, 16);
            this.lblmax01.TabIndex = 24;
            this.lblmax01.Text = "min/max";
            // 
            // lblmax02
            // 
            this.lblmax02.BackColor = System.Drawing.Color.DimGray;
            this.lblmax02.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblmax02.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.lblmax02.Location = new System.Drawing.Point(122, 16);
            this.lblmax02.Name = "lblmax02";
            this.lblmax02.Size = new System.Drawing.Size(52, 16);
            this.lblmax02.TabIndex = 26;
            this.lblmax02.Text = "min/max";
            // 
            // lblmin02
            // 
            this.lblmin02.BackColor = System.Drawing.Color.DimGray;
            this.lblmin02.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblmin02.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.lblmin02.Location = new System.Drawing.Point(122, -1);
            this.lblmin02.Name = "lblmin02";
            this.lblmin02.Size = new System.Drawing.Size(52, 16);
            this.lblmin02.TabIndex = 25;
            this.lblmin02.Text = "min/max";
            // 
            // lblTime
            // 
            this.lblTime.AutoSize = true;
            this.lblTime.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblTime.ForeColor = System.Drawing.Color.Green;
            this.lblTime.Location = new System.Drawing.Point(23, 2);
            this.lblTime.Name = "lblTime";
            this.lblTime.Size = new System.Drawing.Size(85, 33);
            this.lblTime.TabIndex = 27;
            this.lblTime.Text = "Time";
            // 
            // button8
            // 
            this.button8.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button8.Image = ((System.Drawing.Image)(resources.GetObject("button8.Image")));
            this.button8.Location = new System.Drawing.Point(151, 3);
            this.button8.Name = "button8";
            this.button8.Size = new System.Drawing.Size(62, 67);
            this.button8.TabIndex = 31;
            this.button8.UseVisualStyleBackColor = true;
            this.button8.Click += new System.EventHandler(this.button8_Click);
            // 
            // lblSystemTime
            // 
            this.lblSystemTime.AutoSize = true;
            this.lblSystemTime.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblSystemTime.ForeColor = System.Drawing.Color.Green;
            this.lblSystemTime.Location = new System.Drawing.Point(24, 37);
            this.lblSystemTime.Name = "lblSystemTime";
            this.lblSystemTime.Size = new System.Drawing.Size(137, 33);
            this.lblSystemTime.TabIndex = 32;
            this.lblSystemTime.Text = "SysTime";
            // 
            // txtTimeSetForTimer
            // 
            this.txtTimeSetForTimer.Location = new System.Drawing.Point(5, 84);
            this.txtTimeSetForTimer.Name = "txtTimeSetForTimer";
            this.txtTimeSetForTimer.Size = new System.Drawing.Size(62, 20);
            this.txtTimeSetForTimer.TabIndex = 33;
            // 
            // button9
            // 
            this.button9.Location = new System.Drawing.Point(68, 84);
            this.button9.Name = "button9";
            this.button9.Size = new System.Drawing.Size(34, 18);
            this.button9.TabIndex = 34;
            this.button9.Text = "TC";
            this.button9.UseVisualStyleBackColor = true;
            this.button9.Click += new System.EventHandler(this.button9_Click);
            // 
            // lblControllerTimePrecision
            // 
            this.lblControllerTimePrecision.AutoSize = true;
            this.lblControllerTimePrecision.Location = new System.Drawing.Point(3, 70);
            this.lblControllerTimePrecision.Name = "lblControllerTimePrecision";
            this.lblControllerTimePrecision.Size = new System.Drawing.Size(46, 13);
            this.lblControllerTimePrecision.TabIndex = 35;
            this.lblControllerTimePrecision.Text = "частота";
            // 
            // textBox3
            // 
            this.textBox3.Location = new System.Drawing.Point(103, 36);
            this.textBox3.Name = "textBox3";
            this.textBox3.Size = new System.Drawing.Size(92, 20);
            this.textBox3.TabIndex = 36;
            // 
            // button10
            // 
            this.button10.BackColor = System.Drawing.Color.PeachPuff;
            this.button10.Image = ((System.Drawing.Image)(resources.GetObject("button10.Image")));
            this.button10.Location = new System.Drawing.Point(0, 19);
            this.button10.Name = "button10";
            this.button10.Size = new System.Drawing.Size(18, 23);
            this.button10.TabIndex = 37;
            this.button10.UseVisualStyleBackColor = false;
            this.button10.Click += new System.EventHandler(this.button10_Click);
            // 
            // timer3
            // 
            this.timer3.Interval = 10000;
            this.timer3.Tick += new System.EventHandler(this.timer3_Tick);
            // 
            // button11
            // 
            this.button11.Location = new System.Drawing.Point(58, 91);
            this.button11.Name = "button11";
            this.button11.Size = new System.Drawing.Size(38, 21);
            this.button11.TabIndex = 38;
            this.button11.Text = "On";
            this.button11.UseVisualStyleBackColor = true;
            this.button11.Click += new System.EventHandler(this.button11_Click);
            // 
            // button12
            // 
            this.button12.Location = new System.Drawing.Point(93, 91);
            this.button12.Name = "button12";
            this.button12.Size = new System.Drawing.Size(38, 21);
            this.button12.TabIndex = 39;
            this.button12.Text = "Off";
            this.button12.UseVisualStyleBackColor = true;
            this.button12.Click += new System.EventHandler(this.button12_Click);
            // 
            // button17
            // 
            this.button17.Location = new System.Drawing.Point(93, 110);
            this.button17.Name = "button17";
            this.button17.Size = new System.Drawing.Size(38, 21);
            this.button17.TabIndex = 45;
            this.button17.Text = "Off";
            this.button17.UseVisualStyleBackColor = true;
            this.button17.Click += new System.EventHandler(this.button17_Click);
            // 
            // button18
            // 
            this.button18.Location = new System.Drawing.Point(58, 110);
            this.button18.Name = "button18";
            this.button18.Size = new System.Drawing.Size(38, 21);
            this.button18.TabIndex = 44;
            this.button18.Text = "On";
            this.button18.UseVisualStyleBackColor = true;
            this.button18.Click += new System.EventHandler(this.button18_Click);
            // 
            // button13
            // 
            this.button13.Location = new System.Drawing.Point(93, 130);
            this.button13.Name = "button13";
            this.button13.Size = new System.Drawing.Size(38, 21);
            this.button13.TabIndex = 47;
            this.button13.Text = "Off";
            this.button13.UseVisualStyleBackColor = true;
            this.button13.Click += new System.EventHandler(this.button13_Click);
            // 
            // button14
            // 
            this.button14.Location = new System.Drawing.Point(58, 130);
            this.button14.Name = "button14";
            this.button14.Size = new System.Drawing.Size(38, 21);
            this.button14.TabIndex = 46;
            this.button14.Text = "On";
            this.button14.UseVisualStyleBackColor = true;
            this.button14.Click += new System.EventHandler(this.button14_Click);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label5.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(64)))));
            this.label5.Location = new System.Drawing.Point(2, 113);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(55, 16);
            this.label5.TabIndex = 48;
            this.label5.Text = "Выдув";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label6.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(64)))));
            this.label6.Location = new System.Drawing.Point(8, 132);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(44, 16);
            this.label6.TabIndex = 49;
            this.label6.Text = "Свет";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label7.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(64)))));
            this.label7.Location = new System.Drawing.Point(3, 93);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(55, 16);
            this.label7.TabIndex = 50;
            this.label7.Text = "Обдув";
            // 
            // txtDayStart
            // 
            this.txtDayStart.Location = new System.Drawing.Point(6, 67);
            this.txtDayStart.Name = "txtDayStart";
            this.txtDayStart.Size = new System.Drawing.Size(73, 20);
            this.txtDayStart.TabIndex = 51;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label8.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(64)))));
            this.label8.Location = new System.Drawing.Point(3, 47);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(109, 16);
            this.label8.TabIndex = 52;
            this.label8.Text = "Время старта";
            // 
            // button15
            // 
            this.button15.Location = new System.Drawing.Point(80, 65);
            this.button15.Name = "button15";
            this.button15.Size = new System.Drawing.Size(28, 22);
            this.button15.TabIndex = 53;
            this.button15.Text = "Ok";
            this.button15.UseVisualStyleBackColor = true;
            this.button15.Click += new System.EventHandler(this.button15_Click);
            // 
            // button16
            // 
            this.button16.Location = new System.Drawing.Point(3, 24);
            this.button16.Name = "button16";
            this.button16.Size = new System.Drawing.Size(46, 21);
            this.button16.TabIndex = 55;
            this.button16.Text = "12/12";
            this.button16.UseVisualStyleBackColor = true;
            this.button16.Click += new System.EventHandler(this.button16_Click);
            // 
            // button19
            // 
            this.button19.Location = new System.Drawing.Point(3, 3);
            this.button19.Name = "button19";
            this.button19.Size = new System.Drawing.Size(46, 21);
            this.button19.TabIndex = 54;
            this.button19.Text = "18/6";
            this.button19.UseVisualStyleBackColor = true;
            this.button19.Click += new System.EventHandler(this.button19_Click);
            // 
            // button20
            // 
            this.button20.Location = new System.Drawing.Point(149, 219);
            this.button20.Name = "button20";
            this.button20.Size = new System.Drawing.Size(14, 15);
            this.button20.TabIndex = 57;
            this.button20.Text = "*";
            this.button20.UseVisualStyleBackColor = true;
            this.button20.Click += new System.EventHandler(this.button20_Click);
            // 
            // timer4
            // 
            this.timer4.Interval = 250;
            this.timer4.Tick += new System.EventHandler(this.timer4_Tick);
            // 
            // lblDeviceDayStartTime
            // 
            this.lblDeviceDayStartTime.AutoSize = true;
            this.lblDeviceDayStartTime.Location = new System.Drawing.Point(5, 148);
            this.lblDeviceDayStartTime.Name = "lblDeviceDayStartTime";
            this.lblDeviceDayStartTime.Size = new System.Drawing.Size(48, 13);
            this.lblDeviceDayStartTime.TabIndex = 59;
            this.lblDeviceDayStartTime.Text = "DayStart";
            // 
            // txtPeriodAset
            // 
            this.txtPeriodAset.Location = new System.Drawing.Point(52, 6);
            this.txtPeriodAset.Name = "txtPeriodAset";
            this.txtPeriodAset.Size = new System.Drawing.Size(42, 20);
            this.txtPeriodAset.TabIndex = 62;
            // 
            // txtPeriodBset
            // 
            this.txtPeriodBset.Location = new System.Drawing.Point(52, 27);
            this.txtPeriodBset.Name = "txtPeriodBset";
            this.txtPeriodBset.Size = new System.Drawing.Size(42, 20);
            this.txtPeriodBset.TabIndex = 63;
            // 
            // btnPeriodAset
            // 
            this.btnPeriodAset.Location = new System.Drawing.Point(94, 4);
            this.btnPeriodAset.Name = "btnPeriodAset";
            this.btnPeriodAset.Size = new System.Drawing.Size(38, 21);
            this.btnPeriodAset.TabIndex = 64;
            this.btnPeriodAset.Text = "a set";
            this.btnPeriodAset.UseVisualStyleBackColor = true;
            this.btnPeriodAset.Click += new System.EventHandler(this.btnPeriodAset_Click);
            // 
            // btnPeriodBset
            // 
            this.btnPeriodBset.Location = new System.Drawing.Point(94, 25);
            this.btnPeriodBset.Name = "btnPeriodBset";
            this.btnPeriodBset.Size = new System.Drawing.Size(38, 22);
            this.btnPeriodBset.TabIndex = 65;
            this.btnPeriodBset.Text = "b set";
            this.btnPeriodBset.UseVisualStyleBackColor = true;
            this.btnPeriodBset.Click += new System.EventHandler(this.btnPeriodBset_Click);
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label10.ForeColor = System.Drawing.Color.DarkGreen;
            this.label10.Location = new System.Drawing.Point(3, 5);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(54, 17);
            this.label10.TabIndex = 68;
            this.label10.Text = "label10";
            // 
            // btnGetDayNumber
            // 
            this.btnGetDayNumber.Location = new System.Drawing.Point(149, 233);
            this.btnGetDayNumber.Name = "btnGetDayNumber";
            this.btnGetDayNumber.Size = new System.Drawing.Size(14, 15);
            this.btnGetDayNumber.TabIndex = 69;
            this.btnGetDayNumber.Text = "*";
            this.btnGetDayNumber.UseVisualStyleBackColor = true;
            this.btnGetDayNumber.Click += new System.EventHandler(this.btnGetDayNumber_Click);
            // 
            // lblDayNumber
            // 
            this.lblDayNumber.AutoSize = true;
            this.lblDayNumber.Location = new System.Drawing.Point(164, 234);
            this.lblDayNumber.Name = "lblDayNumber";
            this.lblDayNumber.Size = new System.Drawing.Size(73, 13);
            this.lblDayNumber.TabIndex = 71;
            this.lblDayNumber.Text = "lblDayNumber";
            // 
            // tmrUpdateDayAndOutput
            // 
            this.tmrUpdateDayAndOutput.Enabled = true;
            this.tmrUpdateDayAndOutput.Interval = 60000;
            this.tmrUpdateDayAndOutput.Tick += new System.EventHandler(this.tmrUpdateDayAndOutput_Tick);
            // 
            // lblUpdateTime
            // 
            this.lblUpdateTime.AutoSize = true;
            this.lblUpdateTime.Location = new System.Drawing.Point(147, 206);
            this.lblUpdateTime.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.lblUpdateTime.Name = "lblUpdateTime";
            this.lblUpdateTime.Size = new System.Drawing.Size(41, 13);
            this.lblUpdateTime.TabIndex = 69;
            this.lblUpdateTime.Text = "label11";
            // 
            // panel2
            // 
            this.panel2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel2.Controls.Add(this.lblT01);
            this.panel2.Controls.Add(this.lblmin01);
            this.panel2.Controls.Add(this.lblmax01);
            this.panel2.Controls.Add(this.btnCheckTemperature);
            this.panel2.Controls.Add(this.button10);
            this.panel2.Location = new System.Drawing.Point(252, 5);
            this.panel2.Margin = new System.Windows.Forms.Padding(2);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(273, 229);
            this.panel2.TabIndex = 72;
            // 
            // panel3
            // 
            this.panel3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel3.Controls.Add(this.button8);
            this.panel3.Controls.Add(this.lblTime);
            this.panel3.Controls.Add(this.lblSystemTime);
            this.panel3.Controls.Add(this.lblControllerTimePrecision);
            this.panel3.Controls.Add(this.txtTimeSetForTimer);
            this.panel3.Controls.Add(this.btnCheckTime);
            this.panel3.Controls.Add(this.button9);
            this.panel3.Location = new System.Drawing.Point(638, 5);
            this.panel3.Margin = new System.Windows.Forms.Padding(2);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(219, 105);
            this.panel3.TabIndex = 73;
            // 
            // lblPeriod
            // 
            this.lblPeriod.AutoSize = true;
            this.lblPeriod.Location = new System.Drawing.Point(164, 219);
            this.lblPeriod.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.lblPeriod.Name = "lblPeriod";
            this.lblPeriod.Size = new System.Drawing.Size(47, 13);
            this.lblPeriod.TabIndex = 36;
            this.lblPeriod.Text = "lblPeriod";
            // 
            // btnLockControl
            // 
            this.btnLockControl.Location = new System.Drawing.Point(200, 38);
            this.btnLockControl.Name = "btnLockControl";
            this.btnLockControl.Size = new System.Drawing.Size(47, 39);
            this.btnLockControl.TabIndex = 74;
            this.btnLockControl.Text = "Lock Control";
            this.btnLockControl.UseVisualStyleBackColor = true;
            this.btnLockControl.Click += new System.EventHandler(this.btnLockControl_Click);
            // 
            // btnUnlockControl
            // 
            this.btnUnlockControl.Location = new System.Drawing.Point(200, 78);
            this.btnUnlockControl.Name = "btnUnlockControl";
            this.btnUnlockControl.Size = new System.Drawing.Size(47, 48);
            this.btnUnlockControl.TabIndex = 75;
            this.btnUnlockControl.Text = "Unlock Control";
            this.btnUnlockControl.UseVisualStyleBackColor = true;
            this.btnUnlockControl.Click += new System.EventHandler(this.btnUnlockControl_Click);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(200, 128);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(47, 42);
            this.button1.TabIndex = 76;
            this.button1.Text = "* temp";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click_1);
            // 
            // panel4
            // 
            this.panel4.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel4.Controls.Add(this.cmdSendData);
            this.panel4.Controls.Add(this.textBox2);
            this.panel4.Controls.Add(this.listBox1);
            this.panel4.Controls.Add(this.textBox1);
            this.panel4.Controls.Add(this.button3);
            this.panel4.Location = new System.Drawing.Point(529, 114);
            this.panel4.Margin = new System.Windows.Forms.Padding(2);
            this.panel4.Name = "panel4";
            this.panel4.Size = new System.Drawing.Size(328, 353);
            this.panel4.TabIndex = 36;
            // 
            // panel5
            // 
            this.panel5.Controls.Add(this.button19);
            this.panel5.Controls.Add(this.button16);
            this.panel5.Controls.Add(this.txtPeriodAset);
            this.panel5.Controls.Add(this.txtPeriodBset);
            this.panel5.Controls.Add(this.btnPeriodAset);
            this.panel5.Controls.Add(this.btnPeriodBset);
            this.panel5.Controls.Add(this.label8);
            this.panel5.Controls.Add(this.txtDayStart);
            this.panel5.Controls.Add(this.button15);
            this.panel5.Controls.Add(this.button11);
            this.panel5.Controls.Add(this.button12);
            this.panel5.Controls.Add(this.button18);
            this.panel5.Controls.Add(this.button17);
            this.panel5.Controls.Add(this.button14);
            this.panel5.Controls.Add(this.button13);
            this.panel5.Controls.Add(this.lblDeviceDayStartTime);
            this.panel5.Controls.Add(this.label5);
            this.panel5.Controls.Add(this.label6);
            this.panel5.Controls.Add(this.label7);
            this.panel5.Location = new System.Drawing.Point(6, 173);
            this.panel5.Margin = new System.Windows.Forms.Padding(2);
            this.panel5.Name = "panel5";
            this.panel5.Size = new System.Drawing.Size(136, 165);
            this.panel5.TabIndex = 77;
            // 
            // lblPeriodALen
            // 
            this.lblPeriodALen.AutoSize = true;
            this.lblPeriodALen.Location = new System.Drawing.Point(147, 173);
            this.lblPeriodALen.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.lblPeriodALen.Name = "lblPeriodALen";
            this.lblPeriodALen.Size = new System.Drawing.Size(72, 13);
            this.lblPeriodALen.TabIndex = 79;
            this.lblPeriodALen.Text = "lblPeriodALen";
            // 
            // lblPeriodBLen
            // 
            this.lblPeriodBLen.AutoSize = true;
            this.lblPeriodBLen.Location = new System.Drawing.Point(147, 187);
            this.lblPeriodBLen.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.lblPeriodBLen.Name = "lblPeriodBLen";
            this.lblPeriodBLen.Size = new System.Drawing.Size(72, 13);
            this.lblPeriodBLen.TabIndex = 80;
            this.lblPeriodBLen.Text = "lblPeriodBLen";
            // 
            // panel6
            // 
            this.panel6.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel6.Controls.Add(this.lblT02);
            this.panel6.Controls.Add(this.lblmax02);
            this.panel6.Controls.Add(this.lblmin02);
            this.panel6.Location = new System.Drawing.Point(252, 238);
            this.panel6.Margin = new System.Windows.Forms.Padding(2);
            this.panel6.Name = "panel6";
            this.panel6.Size = new System.Drawing.Size(273, 229);
            this.panel6.TabIndex = 83;
            this.panel6.Paint += new System.Windows.Forms.PaintEventHandler(this.panel6_Paint);
            // 
            // textBox4
            // 
            this.textBox4.Location = new System.Drawing.Point(104, 347);
            this.textBox4.Multiline = true;
            this.textBox4.Name = "textBox4";
            this.textBox4.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.textBox4.Size = new System.Drawing.Size(363, 119);
            this.textBox4.TabIndex = 84;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.DarkGray;
            this.ClientSize = new System.Drawing.Size(861, 473);
            this.Controls.Add(this.textBox4);
            this.Controls.Add(this.panel6);
            this.Controls.Add(this.lblPeriodBLen);
            this.Controls.Add(this.lblPeriodALen);
            this.Controls.Add(this.panel5);
            this.Controls.Add(this.txtThermometerCounter);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.panel4);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.btnUnlockControl);
            this.Controls.Add(this.btnLockControl);
            this.Controls.Add(this.lblPeriod);
            this.Controls.Add(this.lblDayNumber);
            this.Controls.Add(this.panel3);
            this.Controls.Add(this.lblUpdateTime);
            this.Controls.Add(this.label10);
            this.Controls.Add(this.btnGetDayNumber);
            this.Controls.Add(this.comboBox1);
            this.Controls.Add(this.cmdConnect);
            this.Controls.Add(this.button20);
            this.Controls.Add(this.textBox3);
            this.Controls.Add(this.panel1);
            this.Name = "Form1";
            this.Text = "Themperature Logger";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.Load += new System.EventHandler(this.Form1_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            this.panel4.ResumeLayout(false);
            this.panel4.PerformLayout();
            this.panel5.ResumeLayout(false);
            this.panel5.PerformLayout();
            this.panel6.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.IO.Ports.SerialPort SerialPort1;
        private System.Windows.Forms.Button cmdConnect;
        private System.Windows.Forms.ComboBox comboBox1;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Button cmdSendData;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.Timer timer2;
        private System.Windows.Forms.TextBox txtThermometerCounter;
        private System.Windows.Forms.ListBox listBox1;
        private System.Windows.Forms.Label lblT01;
        private System.Windows.Forms.Label lblT02;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Button cmdTimeGetTemperatureSet;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtTimeGetTemperature;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.TextBox lblClearTime;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label lblmin01;
        private System.Windows.Forms.Label lblmax01;
        private System.Windows.Forms.Label lblmax02;
        private System.Windows.Forms.Label lblmin02;
        private System.Windows.Forms.Label lblTime;
        private System.Windows.Forms.Button button8;
        private System.Windows.Forms.Label lblSystemTime;
        private System.Windows.Forms.TextBox txtTimeSetForTimer;
        private System.Windows.Forms.Button button9;
        private System.Windows.Forms.Label lblControllerTimePrecision;
        private System.Windows.Forms.TextBox textBox3;
        private System.Windows.Forms.Button button10;
        private System.Windows.Forms.Timer timer3;
        private System.Windows.Forms.Button button11;
        private System.Windows.Forms.Button button12;
        private System.Windows.Forms.Button button17;
        private System.Windows.Forms.Button button18;
        private System.Windows.Forms.Button button13;
        private System.Windows.Forms.Button button14;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox txtDayStart;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Button button15;
        private System.Windows.Forms.Button button16;
        private System.Windows.Forms.Button button19;
        private System.Windows.Forms.Button button20;
        private System.Windows.Forms.Timer timer4;
        private System.Windows.Forms.Label lblDeviceDayStartTime;
        private System.Windows.Forms.TextBox txtPeriodAset;
        private System.Windows.Forms.TextBox txtPeriodBset;
        private System.Windows.Forms.Button btnPeriodAset;
        private System.Windows.Forms.Button btnPeriodBset;
        private System.Windows.Forms.Button btnCheckTemperature;
        private System.Windows.Forms.Button btnCheckTime;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Button btnGetDayNumber;
        private System.Windows.Forms.Button btnGetOutputStatus;
        private System.Windows.Forms.Label lblDayNumber;
        private System.Windows.Forms.Timer tmrUpdateDayAndOutput;
        private System.Windows.Forms.Label lblUpdateTime;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.Label lblPeriod;
        private System.Windows.Forms.Button btnLockControl;
        private System.Windows.Forms.Button btnUnlockControl;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Panel panel4;
        private System.Windows.Forms.Panel panel5;
        private System.Windows.Forms.Label lblPeriodALen;
        private System.Windows.Forms.Label lblPeriodBLen;
        private System.Windows.Forms.Panel panel6;
        private System.Windows.Forms.TextBox textBox4;
    }
}

