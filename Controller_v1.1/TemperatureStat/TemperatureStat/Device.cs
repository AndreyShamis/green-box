using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.IO.Ports;              //  for get all aviables COM ports in OS
using System.Collections;
using System.Timers;

namespace TemperatureStat
{
    
    public class Device
    {
        private const string    ENABLE_OBDUV        =   "ENOB";
        private const string    ENABLE_VIDUV        =   "ENVI";
        private const string    ENABLE_LIGHT        =   "ENLI";
        private const string    DISABLE_OBDUV       =   "DIOB";
        private const string    DISABLE_VIDUV       =   "DIVI";
        private const string    DISABLE_LIGHT       =   "DILI";
        private const string GET_TIME = "TM";
        private const string SET_DAY_START = "SETDST";
        private const string GET_DAY_START = "GETDST";
        private const string SET_PERIOD = "SETPER";
        private const string GET_PERIOD = "GETPER";
        private const string GET_THERMOMTER_COUNTER = "THCO";
        private const string GET_THERMOMETER_IDs = "SD";
        private const string GET_TEMPERATURE = "GT";
        private const string SEND_TEST = "TEST";
        private const string TIME_UPDATE_FULL = "TUF";
        private const string GET_TIME_PRECISION = "STPR";
        private const string GET_PERIOD_A_LEN = "GETPAL";
        private const string GET_PERIOD_B_LEN = "GETPBL";
        private const string SET_PERIOD_A_LEN = "SETPAL";
        private const string SET_PERIOD_B_LEN = "SETPBL";
        private const string GET_OUTPUT_STATUS = "GETOPS";
        private const string GET_DAY_NUMBER = "GETDN";
        private const string CONTROL_LOCK = "LOCKC";
        private const string CONTROL_UNLOCK = "UNLOCKC";
        private const string CONTROL_AGRESIVE_TEMP_CHECK = "AGRESTCH";

        public void getAgresiveTemperature()
        {
            SendData(CONTROL_AGRESIVE_TEMP_CHECK);
        }
        public void getUnLockOnControl()
        {
            SendData(CONTROL_UNLOCK);
        }
        public void getLockOnControl()
        {
            SendData(CONTROL_LOCK);
        }
        public void getOutputStatus()
        {
            SendData(GET_OUTPUT_STATUS);
        }
        public enum Period
        {
            PERIOD_18_6 ,
            PERIOD_12_12 ,
        }
        public void getDayNumber()
        {
            SendData(GET_DAY_NUMBER);
        }        
        private SerialPort _comPort = new SerialPort("COM1", 19200, Parity.None, 8, StopBits.One);

        private System.Timers.Timer _timer = new System.Timers.Timer();
        private System.Timers.Timer _timerSender = new System.Timers.Timer();

        
        public ArrayList temp1 = new ArrayList();
        public ArrayList temp2 = new ArrayList();
        private bool _deviceConnectedStatus = false;
        private int _thermometerCounter;

        private ArrayList _dataToSend = new ArrayList();
        public void getPeriodBLen()
        {
            SendData(GET_PERIOD_B_LEN);
        }
        public void getPeriodALen()
        {
            SendData(GET_PERIOD_A_LEN);
        }
        public void getDayStart()
        {
            SendData(GET_DAY_START);
        }
        public void getTimePrecision()
        {
            SendData(GET_TIME_PRECISION);
        }
        public void UpdateTime()
        {

            SendData(TIME_UPDATE_FULL 
                + ConvertTimeToNetworkData(DateTime.Now.Hour.ToString())
                + ConvertTimeToNetworkData(DateTime.Now.Minute.ToString())
                + ConvertTimeToNetworkData(DateTime.Now.Second.ToString()));
        } 
        private char ConvertTimeToNetworkData(String data)
        {
            Int32 timeToUpdate = Convert.ToInt32(data)+50;
            return( (char)timeToUpdate);
     
        }
        public void setPeriodBLen(String data)
        {
            Int32 val = Convert.ToInt32(data);
            SendData(SET_PERIOD_B_LEN +  (char)val);
        }
        public void setPeriodALen(String data)
        {
            Int32 val = Convert.ToInt32(data);
            SendData(SET_PERIOD_A_LEN + (char)val);
        }

        public void Connect()
        {
            SendData(SEND_TEST);
        }
        public void getTemperature()
        {
            SendData(GET_TEMPERATURE);
        }
        public void getThermometersID()
        {
            SendData(GET_THERMOMETER_IDs);
        }

        public void ThermometerCount()
        {
            SendData(GET_THERMOMTER_COUNTER);
        }
        public void setPeriod(Period newPeriod)
        {
            if (newPeriod == Period.PERIOD_18_6)
                SendData(SET_PERIOD + "a");
            else if(newPeriod == Period.PERIOD_12_12)
                SendData(SET_PERIOD + "b");
        }
        public void getPeriod()
        {
            SendData(GET_PERIOD);
        }
        public void setDayStart(Int32 value)
        {
            SendData(SET_DAY_START + (char)(value));
        }
        public int ThermometerCounter
        {
            get { return _thermometerCounter; }
            set { _thermometerCounter = value; }
        }
        public void getTime()
        {
            SendData(GET_TIME);
        }
        public void DisableObduv()
        {
            SendData(DISABLE_OBDUV);
        }
        public void DisableViduv()
        {
            SendData(DISABLE_VIDUV);
        }
        public void DisableLight()
        {
            SendData(DISABLE_LIGHT);
        }
        public void EanbleObduv()
        {
            SendData(ENABLE_OBDUV);
        }
        public void EanbleViduv()
        {
            SendData(ENABLE_VIDUV);
        }
        public void EanbleLight()
        {
            SendData(ENABLE_LIGHT);
        }
        public bool DevStat
        {
            get { return _deviceConnectedStatus; }
            set { _deviceConnectedStatus = value; }
        }

        public Device()
        {
            _comPort.Handshake = Handshake.None;
            _comPort.BaudRate = 9600;
            _comPort.DataBits = 8;
            _comPort.WriteTimeout = 500;
            _comPort.DataReceived += new SerialDataReceivedEventHandler(sp_DataRecived);
            _timer.Elapsed += new ElapsedEventHandler(TimerEvent);
            _timer.Interval = 10000;
            _timer.Enabled = true;
            _timer.AutoReset = false;

            _timerSender.Elapsed += new ElapsedEventHandler(TimerEventSender);
            _timerSender.Interval = 10000;
            _timerSender.Enabled = true;
            _timerSender.AutoReset = false;

        }

        private void sp_DataRecived(object handler, SerialDataReceivedEventArgs e)
        {
            
        }

        public void SendData(String data)
        {
            bool canAdd = true;
            for (int i = 0; i < _dataToSend.Count;i++ )
            {
                if(_dataToSend[i].Equals(data))
                {
                    canAdd = false;
                    break;
                }
            }
            if (canAdd)
                _dataToSend.Add(data);
        }
        public bool ifHaveCommandToSend()
        {
            if (_dataToSend.Count > 0)
                return true;
            else
            {
                return false;
            }
        }
        public String GetCommand()
        {
            String ret = "";
            if (_dataToSend.Count > 0)
            {
                //_comPort.Write(_dataToSend[0].ToString());
                ret = _dataToSend[0].ToString();
                _dataToSend.RemoveAt(0);
            }
            return (ret);
        }
        private static void TimerEvent(object source , ElapsedEventArgs e)
        {
            
        }
        private  void TimerEventSender(object source, ElapsedEventArgs e)
        {
            if(_dataToSend.Count > 0)
            {
               // _comPort.Write(_dataToSend[0].ToString());
               // _dataToSend.Remove(0);
            }
        }
    }
}
