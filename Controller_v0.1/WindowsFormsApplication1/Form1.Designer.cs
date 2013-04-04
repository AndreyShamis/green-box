namespace WindowsFormsApplication1
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
            this.comboBox1 = new System.Windows.Forms.ComboBox();
            this.serialPort1 = new System.IO.Ports.SerialPort(this.components);
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.cmdConnect = new System.Windows.Forms.Button();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.lblDeviceTime = new System.Windows.Forms.Label();
            this.listBox1 = new System.Windows.Forms.ListBox();
            this.lblLightStatus = new System.Windows.Forms.Label();
            this.lblFanObduv = new System.Windows.Forms.Label();
            this.lblFanViduv = new System.Windows.Forms.Label();
            this.lblLoaclTime = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.button5 = new System.Windows.Forms.Button();
            this.button6 = new System.Windows.Forms.Button();
            this.button7 = new System.Windows.Forms.Button();
            this.button8 = new System.Windows.Forms.Button();
            this.button9 = new System.Windows.Forms.Button();
            this.button10 = new System.Windows.Forms.Button();
            this.label9 = new System.Windows.Forms.Label();
            this.listBox2 = new System.Windows.Forms.ListBox();
            this.cmdClearR = new System.Windows.Forms.Button();
            this.cmdClearT = new System.Windows.Forms.Button();
            this.lblThrmCounter = new System.Windows.Forms.Label();
            this.label11 = new System.Windows.Forms.Label();
            this.label12 = new System.Windows.Forms.Label();
            this.lblReceived = new System.Windows.Forms.Label();
            this.lblTransmited = new System.Windows.Forms.Label();
            this.label14 = new System.Windows.Forms.Label();
            this.label13 = new System.Windows.Forms.Label();
            this.textBox3 = new System.Windows.Forms.TextBox();
            this.button11 = new System.Windows.Forms.Button();
            this.label15 = new System.Windows.Forms.Label();
            this.label16 = new System.Windows.Forms.Label();
            this.button12 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // comboBox1
            // 
            this.comboBox1.DisplayMember = "1";
            this.comboBox1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox1.FormattingEnabled = true;
            this.comboBox1.Location = new System.Drawing.Point(111, 10);
            this.comboBox1.Name = "comboBox1";
            this.comboBox1.Size = new System.Drawing.Size(57, 21);
            this.comboBox1.Sorted = true;
            this.comboBox1.TabIndex = 0;
            this.comboBox1.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            // 
            // textBox1
            // 
            this.textBox1.Enabled = false;
            this.textBox1.Location = new System.Drawing.Point(12, 227);
            this.textBox1.Multiline = true;
            this.textBox1.Name = "textBox1";
            this.textBox1.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.textBox1.Size = new System.Drawing.Size(469, 57);
            this.textBox1.TabIndex = 1;
            this.textBox1.TextChanged += new System.EventHandler(this.textBox1_TextChanged);
            this.textBox1.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.textBox1_KeyPress);
            this.textBox1.KeyUp += new System.Windows.Forms.KeyEventHandler(this.textBox1_KeyUp);
            // 
            // textBox2
            // 
            this.textBox2.BackColor = System.Drawing.Color.LightBlue;
            this.textBox2.Location = new System.Drawing.Point(12, 316);
            this.textBox2.Multiline = true;
            this.textBox2.Name = "textBox2";
            this.textBox2.ReadOnly = true;
            this.textBox2.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.textBox2.Size = new System.Drawing.Size(468, 67);
            this.textBox2.TabIndex = 2;
            // 
            // cmdConnect
            // 
            this.cmdConnect.BackColor = System.Drawing.Color.Lime;
            this.cmdConnect.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.cmdConnect.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.cmdConnect.Location = new System.Drawing.Point(12, 10);
            this.cmdConnect.Name = "cmdConnect";
            this.cmdConnect.Size = new System.Drawing.Size(93, 22);
            this.cmdConnect.TabIndex = 3;
            this.cmdConnect.Text = "Connect";
            this.cmdConnect.UseVisualStyleBackColor = false;
            this.cmdConnect.Click += new System.EventHandler(this.cmdConnect_Click);
            // 
            // timer1
            // 
            this.timer1.Enabled = true;
            this.timer1.Interval = 500;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 386);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(35, 13);
            this.label1.TabIndex = 4;
            this.label1.Text = "label1";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.label2.Location = new System.Drawing.Point(288, 38);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(87, 16);
            this.label2.TabIndex = 6;
            this.label2.Text = "Device time:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.label3.Location = new System.Drawing.Point(288, 12);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(79, 16);
            this.label3.TabIndex = 7;
            this.label3.Text = "Local time:";
            // 
            // lblDeviceTime
            // 
            this.lblDeviceTime.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.lblDeviceTime.Location = new System.Drawing.Point(413, 38);
            this.lblDeviceTime.Name = "lblDeviceTime";
            this.lblDeviceTime.Size = new System.Drawing.Size(56, 16);
            this.lblDeviceTime.TabIndex = 8;
            this.lblDeviceTime.Text = "15:49";
            this.lblDeviceTime.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // listBox1
            // 
            this.listBox1.FormattingEnabled = true;
            this.listBox1.Items.AddRange(new object[] {
            "CM:W:LI:0",
            "CM:W:LI:1",
            "CM:W:FO:0",
            "CM:W:FO:1",
            "CM:W:FV:0",
            "CM:W:FV:1",
            "CM:W:TR",
            "CM:W:S1:0",
            "CM:W:S1:1",
            "CM:W:S2:0",
            "CM:W:S2:1",
            "CM:R:LI",
            "CM:R:FO",
            "CM:R:FV",
            "CM:R:TR:C",
            "CM:R:TR:?"});
            this.listBox1.Location = new System.Drawing.Point(487, 37);
            this.listBox1.Name = "listBox1";
            this.listBox1.Size = new System.Drawing.Size(147, 355);
            this.listBox1.TabIndex = 9;
            this.listBox1.MouseClick += new System.Windows.Forms.MouseEventHandler(this.listBox1_MouseClick);
            this.listBox1.SelectedIndexChanged += new System.EventHandler(this.listBox1_SelectedIndexChanged);
            this.listBox1.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.listBox1_MouseDoubleClick);
            // 
            // lblLightStatus
            // 
            this.lblLightStatus.BackColor = System.Drawing.Color.Silver;
            this.lblLightStatus.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblLightStatus.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.lblLightStatus.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.lblLightStatus.Location = new System.Drawing.Point(12, 42);
            this.lblLightStatus.Name = "lblLightStatus";
            this.lblLightStatus.Size = new System.Drawing.Size(60, 17);
            this.lblLightStatus.TabIndex = 10;
            this.lblLightStatus.Text = "Light";
            this.lblLightStatus.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblFanObduv
            // 
            this.lblFanObduv.BackColor = System.Drawing.Color.Silver;
            this.lblFanObduv.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblFanObduv.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.lblFanObduv.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.lblFanObduv.Location = new System.Drawing.Point(169, 100);
            this.lblFanObduv.Name = "lblFanObduv";
            this.lblFanObduv.Size = new System.Drawing.Size(60, 17);
            this.lblFanObduv.TabIndex = 11;
            this.lblFanObduv.Text = "FAN 1";
            this.lblFanObduv.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblFanViduv
            // 
            this.lblFanViduv.BackColor = System.Drawing.Color.Silver;
            this.lblFanViduv.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblFanViduv.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.lblFanViduv.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.lblFanViduv.Location = new System.Drawing.Point(169, 158);
            this.lblFanViduv.Name = "lblFanViduv";
            this.lblFanViduv.Size = new System.Drawing.Size(60, 17);
            this.lblFanViduv.TabIndex = 12;
            this.lblFanViduv.Text = "FAN 2";
            this.lblFanViduv.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            this.lblFanViduv.Click += new System.EventHandler(this.label6_Click);
            // 
            // lblLoaclTime
            // 
            this.lblLoaclTime.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.lblLoaclTime.Location = new System.Drawing.Point(416, 11);
            this.lblLoaclTime.Name = "lblLoaclTime";
            this.lblLoaclTime.Size = new System.Drawing.Size(53, 16);
            this.lblLoaclTime.TabIndex = 13;
            this.lblLoaclTime.Text = "15:49";
            this.lblLoaclTime.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // label7
            // 
            this.label7.BackColor = System.Drawing.Color.Silver;
            this.label7.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.label7.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.label7.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.label7.Location = new System.Drawing.Point(78, 42);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(60, 17);
            this.label7.TabIndex = 14;
            this.label7.Text = "Status 1";
            this.label7.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // label8
            // 
            this.label8.BackColor = System.Drawing.Color.Silver;
            this.label8.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.label8.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.label8.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.label8.Location = new System.Drawing.Point(12, 100);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(60, 17);
            this.label8.TabIndex = 15;
            this.label8.Text = "Status 2";
            this.label8.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // button1
            // 
            this.button1.Font = new System.Drawing.Font("Arial", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.button1.Location = new System.Drawing.Point(12, 63);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(27, 20);
            this.button1.TabIndex = 16;
            this.button1.Text = "On";
            this.button1.UseVisualStyleBackColor = true;
            // 
            // button2
            // 
            this.button2.Font = new System.Drawing.Font("Arial", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.button2.Location = new System.Drawing.Point(43, 63);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(29, 20);
            this.button2.TabIndex = 17;
            this.button2.Text = "Off";
            this.button2.UseVisualStyleBackColor = true;
            // 
            // button3
            // 
            this.button3.Font = new System.Drawing.Font("Arial", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.button3.Location = new System.Drawing.Point(200, 122);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(29, 20);
            this.button3.TabIndex = 19;
            this.button3.Text = "Off";
            this.button3.UseVisualStyleBackColor = true;
            // 
            // button4
            // 
            this.button4.Font = new System.Drawing.Font("Arial", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.button4.Location = new System.Drawing.Point(169, 122);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(27, 20);
            this.button4.TabIndex = 18;
            this.button4.Text = "On";
            this.button4.UseVisualStyleBackColor = true;
            // 
            // button5
            // 
            this.button5.Font = new System.Drawing.Font("Arial", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.button5.Location = new System.Drawing.Point(200, 180);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(29, 20);
            this.button5.TabIndex = 21;
            this.button5.Text = "Off";
            this.button5.UseVisualStyleBackColor = true;
            // 
            // button6
            // 
            this.button6.Font = new System.Drawing.Font("Arial", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.button6.Location = new System.Drawing.Point(169, 180);
            this.button6.Name = "button6";
            this.button6.Size = new System.Drawing.Size(27, 20);
            this.button6.TabIndex = 20;
            this.button6.Text = "On";
            this.button6.UseVisualStyleBackColor = true;
            // 
            // button7
            // 
            this.button7.Font = new System.Drawing.Font("Arial", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.button7.Location = new System.Drawing.Point(109, 62);
            this.button7.Name = "button7";
            this.button7.Size = new System.Drawing.Size(29, 20);
            this.button7.TabIndex = 23;
            this.button7.Text = "N";
            this.button7.UseVisualStyleBackColor = true;
            // 
            // button8
            // 
            this.button8.Font = new System.Drawing.Font("Arial", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.button8.Location = new System.Drawing.Point(78, 62);
            this.button8.Name = "button8";
            this.button8.Size = new System.Drawing.Size(27, 20);
            this.button8.TabIndex = 22;
            this.button8.Text = "D";
            this.button8.UseVisualStyleBackColor = true;
            // 
            // button9
            // 
            this.button9.Font = new System.Drawing.Font("Arial", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.button9.Location = new System.Drawing.Point(43, 120);
            this.button9.Name = "button9";
            this.button9.Size = new System.Drawing.Size(29, 20);
            this.button9.TabIndex = 25;
            this.button9.Text = "B";
            this.button9.UseVisualStyleBackColor = true;
            // 
            // button10
            // 
            this.button10.Font = new System.Drawing.Font("Arial", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.button10.Location = new System.Drawing.Point(12, 120);
            this.button10.Name = "button10";
            this.button10.Size = new System.Drawing.Size(27, 20);
            this.button10.TabIndex = 24;
            this.button10.Text = "A";
            this.button10.UseVisualStyleBackColor = true;
            // 
            // label9
            // 
            this.label9.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.label9.ForeColor = System.Drawing.Color.Chocolate;
            this.label9.Location = new System.Drawing.Point(82, 103);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(65, 37);
            this.label9.TabIndex = 26;
            this.label9.Text = "A = 12/12\r\nB = 16/8";
            // 
            // listBox2
            // 
            this.listBox2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.listBox2.FormattingEnabled = true;
            this.listBox2.Items.AddRange(new object[] {
            "T1: 18.45",
            "T2: 18.49",
            "T2: 19.00"});
            this.listBox2.Location = new System.Drawing.Point(271, 100);
            this.listBox2.Name = "listBox2";
            this.listBox2.ScrollAlwaysVisible = true;
            this.listBox2.Size = new System.Drawing.Size(198, 121);
            this.listBox2.TabIndex = 27;
            // 
            // cmdClearR
            // 
            this.cmdClearR.Location = new System.Drawing.Point(12, 290);
            this.cmdClearR.Name = "cmdClearR";
            this.cmdClearR.Size = new System.Drawing.Size(75, 20);
            this.cmdClearR.TabIndex = 28;
            this.cmdClearR.Text = "Clear";
            this.cmdClearR.UseVisualStyleBackColor = true;
            this.cmdClearR.Click += new System.EventHandler(this.cmdClearR_Click);
            // 
            // cmdClearT
            // 
            this.cmdClearT.Location = new System.Drawing.Point(12, 201);
            this.cmdClearT.Name = "cmdClearT";
            this.cmdClearT.Size = new System.Drawing.Size(75, 20);
            this.cmdClearT.TabIndex = 29;
            this.cmdClearT.Text = "Clear";
            this.cmdClearT.UseVisualStyleBackColor = true;
            this.cmdClearT.Click += new System.EventHandler(this.cmdClearT_Click);
            // 
            // lblThrmCounter
            // 
            this.lblThrmCounter.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.lblThrmCounter.Location = new System.Drawing.Point(427, 63);
            this.lblThrmCounter.Name = "lblThrmCounter";
            this.lblThrmCounter.Size = new System.Drawing.Size(42, 16);
            this.lblThrmCounter.TabIndex = 31;
            this.lblThrmCounter.Text = "0";
            this.lblThrmCounter.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // label11
            // 
            this.label11.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.label11.Location = new System.Drawing.Point(288, 63);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(110, 16);
            this.label11.TabIndex = 30;
            this.label11.Text = "Therm count:";
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(486, 9);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(48, 13);
            this.label12.TabIndex = 32;
            this.label12.Text = "Comandi";
            // 
            // lblReceived
            // 
            this.lblReceived.AutoSize = true;
            this.lblReceived.Location = new System.Drawing.Point(468, 386);
            this.lblReceived.Name = "lblReceived";
            this.lblReceived.Size = new System.Drawing.Size(13, 13);
            this.lblReceived.TabIndex = 41;
            this.lblReceived.Text = "0";
            // 
            // lblTransmited
            // 
            this.lblTransmited.AutoSize = true;
            this.lblTransmited.Location = new System.Drawing.Point(299, 386);
            this.lblTransmited.Name = "lblTransmited";
            this.lblTransmited.Size = new System.Drawing.Size(13, 13);
            this.lblTransmited.TabIndex = 40;
            this.lblTransmited.Text = "0";
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Location = new System.Drawing.Point(446, 386);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(23, 13);
            this.label14.TabIndex = 39;
            this.label14.Text = "Rx:";
            // 
            // label13
            // 
            this.label13.AutoSize = true;
            this.label13.Location = new System.Drawing.Point(277, 386);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(22, 13);
            this.label13.TabIndex = 38;
            this.label13.Text = "Tx:";
            // 
            // textBox3
            // 
            this.textBox3.Location = new System.Drawing.Point(13, 161);
            this.textBox3.Name = "textBox3";
            this.textBox3.Size = new System.Drawing.Size(124, 20);
            this.textBox3.TabIndex = 42;
            this.textBox3.Text = "AN:LI:0";
            // 
            // button11
            // 
            this.button11.Location = new System.Drawing.Point(12, 180);
            this.button11.Name = "button11";
            this.button11.Size = new System.Drawing.Size(54, 22);
            this.button11.TabIndex = 43;
            this.button11.Text = "button11";
            this.button11.UseVisualStyleBackColor = true;
            this.button11.Click += new System.EventHandler(this.button11_Click);
            // 
            // label15
            // 
            this.label15.BackColor = System.Drawing.Color.Pink;
            this.label15.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.label15.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.label15.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.label15.Location = new System.Drawing.Point(291, 292);
            this.label15.Name = "label15";
            this.label15.Size = new System.Drawing.Size(60, 17);
            this.label15.TabIndex = 45;
            this.label15.Text = "Status 1";
            this.label15.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            this.label15.Visible = false;
            // 
            // label16
            // 
            this.label16.BackColor = System.Drawing.Color.LightGreen;
            this.label16.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.label16.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.label16.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(177)));
            this.label16.Location = new System.Drawing.Point(225, 292);
            this.label16.Name = "label16";
            this.label16.Size = new System.Drawing.Size(60, 17);
            this.label16.TabIndex = 44;
            this.label16.Text = "Light";
            this.label16.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            this.label16.Visible = false;
            // 
            // button12
            // 
            this.button12.Location = new System.Drawing.Point(668, 31);
            this.button12.Name = "button12";
            this.button12.Size = new System.Drawing.Size(87, 22);
            this.button12.TabIndex = 46;
            this.button12.Text = "Read";
            this.button12.UseVisualStyleBackColor = true;
            this.button12.Click += new System.EventHandler(this.button12_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(915, 405);
            this.Controls.Add(this.button12);
            this.Controls.Add(this.label15);
            this.Controls.Add(this.label16);
            this.Controls.Add(this.button11);
            this.Controls.Add(this.textBox3);
            this.Controls.Add(this.lblReceived);
            this.Controls.Add(this.lblTransmited);
            this.Controls.Add(this.label14);
            this.Controls.Add(this.label13);
            this.Controls.Add(this.label12);
            this.Controls.Add(this.lblThrmCounter);
            this.Controls.Add(this.label11);
            this.Controls.Add(this.cmdClearT);
            this.Controls.Add(this.cmdClearR);
            this.Controls.Add(this.listBox2);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.button9);
            this.Controls.Add(this.button10);
            this.Controls.Add(this.button7);
            this.Controls.Add(this.button8);
            this.Controls.Add(this.button5);
            this.Controls.Add(this.button6);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.button4);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.lblLoaclTime);
            this.Controls.Add(this.lblFanViduv);
            this.Controls.Add(this.lblFanObduv);
            this.Controls.Add(this.lblLightStatus);
            this.Controls.Add(this.listBox1);
            this.Controls.Add(this.lblDeviceTime);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.cmdConnect);
            this.Controls.Add(this.textBox2);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.comboBox1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.Text = "POMIDORNICA";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox comboBox1;
        private System.IO.Ports.SerialPort serialPort1;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.Button cmdConnect;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lblDeviceTime;
        private System.Windows.Forms.ListBox listBox1;
        private System.Windows.Forms.Label lblLightStatus;
        private System.Windows.Forms.Label lblFanObduv;
        private System.Windows.Forms.Label lblFanViduv;
        private System.Windows.Forms.Label lblLoaclTime;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.Button button6;
        private System.Windows.Forms.Button button7;
        private System.Windows.Forms.Button button8;
        private System.Windows.Forms.Button button9;
        private System.Windows.Forms.Button button10;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.ListBox listBox2;
        private System.Windows.Forms.Button cmdClearR;
        private System.Windows.Forms.Button cmdClearT;
        private System.Windows.Forms.Label lblThrmCounter;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.Label lblReceived;
        private System.Windows.Forms.Label lblTransmited;
        private System.Windows.Forms.Label label14;
        private System.Windows.Forms.Label label13;
        private System.Windows.Forms.TextBox textBox3;
        private System.Windows.Forms.Button button11;
        private System.Windows.Forms.Label label15;
        private System.Windows.Forms.Label label16;
        private System.Windows.Forms.Button button12;
    }
}

