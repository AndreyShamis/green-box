/***************************************************************************************************************
****************************************************************************************************************
****************************************************************************************************************
        Chip type               : ATmega644
        Program type            : Application
        AVR Core Clock frequency: 8,000000 MHz
        Memory model            : Small
        External RAM size       : 0
        Data Stack size         : 1024
****************************************************************************************************************
****************************************************************************************************************
***************************************************************************************************************/
//--------------------------- Include Section --------------------------------------------
#include <mega644.h>
#include <delay.h>
#include <string.h>
#include <stdio.h>
#include <1wire.h>    // 1 Wire Bus interface functions
#include <ds18b20.h>    // DS1820 Temperature Sensor functions
#include "commands.h"

//----------------------------   DEFINE SECTION ------------------------------------------

#define CONTROL_FAN_OBDUV   PORTB.0
#define CONTROL_FAN_VIDUV   PORTB.1
#define CONTROL_LIGHT       PORTB.2
#define ENABLE              1
#define DISABLE             0             

#define     INPUT_SIZE      30
#define     MAX_DS18B20     8       // maximum number of DS1820 devices connected to the 1 Wire bus
#define     _TEMP_CHECK     2     //  Value for time for get temperature from thermometers
#define     TIMER_PREC      122

#define RX_BUFFER_SIZE0     INPUT_SIZE     // USART0 Receiver buffer
#define TX_BUFFER_SIZE0     INPUT_SIZE

#ifndef RXB8
#define RXB8 1
#endif
#ifndef TXB8
#define TXB8 0
#endif
#ifndef UPE
#define UPE 2
#endif
#ifndef DOR
#define DOR 3
#endif
#ifndef FE
#define FE 4
#endif
#ifndef UDRE
#define UDRE 5
#endif
#ifndef RXC
#define RXC 7
#endif

#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<DOR)
#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)
//----------------------------   VARIAVBLE SECTION ---------------------------------------
//eeprom char test;

unsigned char milisec;
unsigned char hours;
unsigned char minutes;
unsigned char seconds;
unsigned char time_chaeck_const;
unsigned char devices;                      // number of DS1820 devices connected to the 1 Wire bus
unsigned char rom_codes[MAX_DS18B20][9];    // DS1820 devices ROM code storage area, 9 bytes are used for each device
float temperature[MAX_DS18B20];

#define WRITE_TRUE 20
#define TEMP_OLD_SIZE 24*5
char temperature_old[MAX_DS18B20][TEMP_OLD_SIZE];
unsigned int temp_old_counter = 0;
char write_old_memory = 1;
char lcd_buffer[INPUT_SIZE];

int control_locker = 0;
unsigned char agresive_check = 0;
char input_buffer[INPUT_SIZE];

unsigned char temp_check = 210;
char rx_buffer0[RX_BUFFER_SIZE0];
char tx_buffer0[TX_BUFFER_SIZE0];

eeprom char offset1 = 0;
eeprom char offset2 = 0;
eeprom char offset3 = 0;

struct STAT_DEV{
    
    unsigned char day ;
    char period ;  
    unsigned char day_start;
    unsigned char period_a_len;
    unsigned char period_b_len;  
    unsigned char hour;
} ;

eeprom struct STAT_DEV dev;
eeprom char offset4 = 0;
//struct STAT_DEV devMEM;
//===========================
#if RX_BUFFER_SIZE0 <= 256
unsigned char   rx_wr_index0,
                rx_rd_index0,
                rx_counter0;
#else
unsigned int    rx_wr_index0,
                rx_rd_index0,
                rx_counter0;
#endif
//===========================
#if TX_BUFFER_SIZE0 <= 256
unsigned char   tx_wr_index0,
                tx_rd_index0,
                tx_counter0;
#else
unsigned int    tx_wr_index0,
                tx_rd_index0,
                tx_counter0;
#endif
bit rx_buffer_overflow0;      // This flag is set on USART0 Receiver buffer overflow


//=============================================================================
interrupt [USART_RXC] void usart_rx_isr(void);
interrupt [USART_TXC] void usart_tx_isr(void);
interrupt [TIM1_OVF] void timer1_ovf_isr(void);
#ifndef _DEBUG_TERMINAL_IO_
    #define _ALTERNATE_GETCHAR_
    #pragma used+
    char getchar(void);         // Get a character from the USART Receiver buffer
    #pragma used-
#endif

#ifndef _DEBUG_TERMINAL_IO_
    #define _ALTERNATE_PUTCHAR_
    #pragma used+
    void putchar(char c);   // Write a character to the USART Transmitter buffer
    #pragma used-
#endif

void SendData(char *data);
void InitilizeMC();
void getData(char *data);
void SendDevs();
char ScanCommand();
char comcmp(char *comm,char *val);
//=============================================================================
void main(void)
{

   // unsigned char temp_check=_TEMP_CHECK;
    unsigned char i;    
    unsigned char clearcommand = 0;   
    
    
    InitilizeMC();
                 
            
    if(dev.hour <24)
        hours = dev.hour;
            
    if(dev.period != PERIOD_A || dev.period != PERIOD_B)
    {
        dev.period = PERIOD_A;
    }    
      
    if(dev.day>250){
        dev.day = 1;
    }
    
    
    if(dev.day_start > 23){
        dev.day_start = 6;
    }                     
    
    if(dev.period_a_len > 23){
        dev.period_a_len = 18 ;
    }                       
    if(dev.period_b_len > 23){
        dev.period_b_len = 12;
    }                         
    
    time_chaeck_const = TIMER_PREC;
    delay_ms(5000);    
    w1_init();

    // Determine the number of DS1820 devices connected to the 1 Wire bus
    devices=w1_search(0xf0,rom_codes);
    #asm("sei")             // Global enable interrupts
    if(devices){
        sprintf(lcd_buffer,"Found %d devs\r\n",devices);
        SendData(lcd_buffer);  
        SendDevs();
    }
    else{
        sprintf(lcd_buffer,"Not Founded\r\n");
        SendData(lcd_buffer);
    }
    
    for (i=0;i<devices;i++){
        if (!ds18b20_init(&rom_codes[i][0],0,39,DS18B20_12BIT_RES)){
           sprintf(lcd_buffer," Init err %u \r\n",i);
           SendData(lcd_buffer);
        }  
        
        delay_ms(100);   
   }     
               CONTROL_FAN_OBDUV = ENABLE;
               CONTROL_FAN_VIDUV = ENABLE;
    while (1)
    {     
      
                
        if(control_locker == 0)
        {
            if(dev.period == PERIOD_A){      
                if(hours >= dev.day_start && hours < (dev.day_start+dev.period_a_len)){
                    CONTROL_LIGHT = ENABLE; 
                }  else{
                   CONTROL_LIGHT = DISABLE; 
                }       
            }
            else if(dev.period == PERIOD_B){
                if(hours >= dev.day_start && hours < (dev.day_start+dev.period_b_len)){
                    CONTROL_LIGHT = ENABLE;    
                }  else{
                   CONTROL_LIGHT = DISABLE;    
                }               
            }     
        } 
        else{
            control_locker++;
            if(control_locker == 30000){
                control_locker = 0;
            }
        }

        //  Start check network data transfer  
        getData(input_buffer);          //  Get trasfered data
               
        //  Every 30 minutes. Set variable for next temperature writing to memory on reading            
        if(write_old_memory != WRITE_TRUE && minutes%30 == 0){
            write_old_memory = WRITE_TRUE;
        }     
        
        if(strcmp(input_buffer,"")!=0)  //  Check if recived some data
        {   
            if(ScanCommand()){          //  If recived command was executed
                clearcommand =200;
            }
            else{
                clearcommand++;         //  else encrease counter for fix command from sender
            }        
            //  Maximum sender can fix-comlite command in 3 trys.
            if(clearcommand >=3){
                memset(input_buffer,'\0',INPUT_SIZE); 
                clearcommand =0;            
            }
        }
        else{
            if(temp_check >= _TEMP_CHECK || agresive_check==1){ 
            agresive_check=0;
            temp_check = 1;     
                 SendData("STOP\r\n");
                for (i=0;i<devices;i++)
                {                                                                              
                    temperature[i] =  ds18b20_temperature(&rom_codes[i][0]);
                    if(temperature[i]>=45 && temperature[i] <52){
                        sprintf(lcd_buffer,"WAR[%d]:%f\r\n",i,temperature[i]);
                        SendData(lcd_buffer);    
                    } 
                    else if(temperature[i]>=52 && temperature[i] <66){
                        sprintf(lcd_buffer,"ALE[%d]:%f\r\n",i,temperature[i]);
                        SendData(lcd_buffer);    
                    }                          
                    else if(temperature[i]>=66)
                    {                        
                        CONTROL_LIGHT = DISABLE; 
                        sprintf(lcd_buffer,"LIOFF[%d]:%f\r\n",i,temperature[i]);
                        SendData(lcd_buffer);                    
                    } 
                    if(write_old_memory == WRITE_TRUE){
                        temperature_old[i][temp_old_counter] =  (int) temperature[i];  
                    }
                    delay_ms(5);
                }      
                if(write_old_memory == WRITE_TRUE){
                      temp_old_counter++;  
                      write_old_memory =0;
                }
              if(temp_old_counter == TEMP_OLD_SIZE){
                     temp_old_counter = 0;
              }
                SendData("START\r\n");  
            }   
        } 
        //  End Check network data transfer    

        delay_ms(50);        
    }
}
//=============================================================================
char comcmp(char *comm,char *val){
    unsigned char counter=0; 
    unsigned char lencom = strlen(comm);
    unsigned char length=strlen(val);
           
    if(lencom <length )  {
        return 0;
    }
    for(counter=0;counter<length;counter++){
        if(comm[counter] != val[counter] )
        {
            return 0;
        }
    }                
    return 1;
}
//=============================================================================
char ScanCommand(){
    unsigned char i;
    
    if(strcmp(input_buffer,GET_THEMPERATURE)==0){   
        for (i=0;i<devices;i++){                                                                              
            sprintf(lcd_buffer,"T[%d]:%.3f\r\n",i,temperature[i]);
            SendData(lcd_buffer);
            delay_ms(40);          // 40
        }  
    }      
    else if(strcmp(input_buffer,THERMOMETERS_COUNT)==0){                
        sprintf(lcd_buffer,"TC:%d\r\n",devices);
        SendData(lcd_buffer);  
    } 
    else if (strcmp(input_buffer,SEND_LOCAL_TIME)==0){
        sprintf(lcd_buffer,"TM:%d:%d:%d\r\n",hours,minutes,seconds);
        SendData(lcd_buffer);       
    } 
    else if (comcmp(input_buffer,TIME_UPDATE_FULL)){ 
        hours       = input_buffer[3]-50;
        minutes     = input_buffer[4]-50;
        seconds     = input_buffer[5]-50;  
    } 
    else if(strcmp(input_buffer,SEND_DEVICES_ID)==0){
        SendDevs();                        
    } 
    else if(strcmp(input_buffer,ENABLE_OBDUV)==0){
        CONTROL_FAN_OBDUV = ENABLE;                  
    }    
     else if(strcmp(input_buffer,ENABLE_VIDUV)==0){
        CONTROL_FAN_VIDUV = ENABLE;                   
    } 
    else if(strcmp(input_buffer,ENABLE_LIGHT)==0){
        CONTROL_LIGHT = ENABLE;                  
    }    
    else if(strcmp(input_buffer,DISABLE_OBDUV)==0){      
        CONTROL_FAN_OBDUV = DISABLE;             
    }     
     else if(strcmp(input_buffer,DISABLE_VIDUV)==0){      

        CONTROL_FAN_VIDUV = DISABLE;               
    }   
    else if(strcmp(input_buffer,DISABLE_LIGHT)==0){
        CONTROL_LIGHT = DISABLE;                  
    }  
    else if(strcmp(input_buffer,COMMAND_TEST)==0) {
        sprintf(lcd_buffer,"TEST:Good.\r\n"); 
        SendData(lcd_buffer); 
    }    
    else if(strcmp(input_buffer,REFIND_DEVICES)==0){
        w1_init();
        devices=w1_search(0xf0,rom_codes);   
        sprintf(lcd_buffer,"TC:%d\r\n",devices);
        SendData(lcd_buffer);
    }   
    else if(comcmp(input_buffer,TIME_CHECK_CONST)){
        
        time_chaeck_const = input_buffer[2];
    }
    else if(strcmp(input_buffer, SEND_TIME_PREC)==0){
        sprintf(lcd_buffer,"STPR%c\r\n",time_chaeck_const); 
        SendData(lcd_buffer);  
    }  
    else if(strcmp(input_buffer,WRITE_HOUR_TO_EEPROM )==0) {
        dev.hour = hours;    
    }   
    else if(strcmp(input_buffer,GET_DAY_NUMBER )==0) {
        sprintf(lcd_buffer,"DAYNUMBER:%d\r\n",dev.day); 
        SendData(lcd_buffer);     
    }                           
    else if(strcmp(input_buffer,AGRESIVE_TEMP_CHECK )==0) {  
        agresive_check = 1;
        sprintf(lcd_buffer,"Agresive Temp Check\r\n"); 
        SendData(lcd_buffer);     
    }  
    else if(strcmp(input_buffer,CONTROL_LOCK )==0) {  
        control_locker = 1;
        sprintf(lcd_buffer,"Under Control\r\n"); 
        SendData(lcd_buffer);     
    }  
    else if(strcmp(input_buffer,CONTROL_UNLOCK )==0) {
        control_locker = 0;
        sprintf(lcd_buffer,"Auto Control\r\n"); 
        SendData(lcd_buffer);     
    }                                                 
    /**************************************************/
    /**************************************************/
    else if(strcmp(input_buffer,GET_PERIOD )==0) {
        sprintf(lcd_buffer,"PERIOD:%c\r\n",dev.period); 
        SendData(lcd_buffer);     
    }  
    else if(strcmp(input_buffer,GET_DAY_START )==0) {
        sprintf(lcd_buffer,"DAY.ST:%c\r\n",dev.day_start); 
        SendData(lcd_buffer);     
    }  
    else if(strcmp(input_buffer,GET_PERIOD_A_LEN )==0) {
        sprintf(lcd_buffer,"PER.A.:%c\r\n", dev.period_a_len);
        SendData(lcd_buffer);     
    }  
    else if(strcmp(input_buffer,GET_PERIOD_B_LEN )==0) {
        sprintf(lcd_buffer,"PER.B.:%c\r\n",dev.period_b_len); 
        SendData(lcd_buffer);     
    } 
    else if(strcmp(input_buffer,GET_OUTPUT_STATUS )==0) {
        sprintf(lcd_buffer,"GETOPS:%c%c%c\r\n",PORTB.0+48,PORTB.1+48,PORTB.2+48); 
        SendData(lcd_buffer);     
    }   
                  
                       
    /**************************************************/
    /**************************************************/  
    else if(comcmp(input_buffer,SET_DAY_NUMBER )) {
        dev.day =  input_buffer[SET_DAY_NUMBER_POS];
        sprintf(lcd_buffer,"SETDNM:%c\r\n",dev.day); 
        SendData(lcd_buffer);     
    }  
    else if(comcmp(input_buffer,SET_PERIOD )) {
        dev.period =  input_buffer[SET_PERIOVD_POS];
        sprintf(lcd_buffer,"PERIOD:%c\r\n",dev.period); 
        SendData(lcd_buffer);     
    }  
    else if(comcmp(input_buffer,SET_DAY_START )) {
        dev.day_start   =  input_buffer[SET_DAY_START_POS];
        sprintf(lcd_buffer,"DAY.ST:%c\r\n",dev.day_start); 
        SendData(lcd_buffer);     
    }  
    else if(comcmp(input_buffer,SET_PERIOD_A_LEN )) { 
        dev.period_a_len   =  input_buffer[SET_PERIOD_A_LEN_POS];
        sprintf(lcd_buffer,"PER.A.:%c\r\n", dev.period_a_len); 
        SendData(lcd_buffer);     
    }  
    else if(comcmp(input_buffer,SET_PERIOD_B_LEN )) { 
        dev.period_b_len   =  input_buffer[SET_PERIOD_B_LEN_POS];
        sprintf(lcd_buffer,"PER.B.:%c\r\n",dev.period_b_len); 
        SendData(lcd_buffer);     
    }
    /**************************************************/
    /**************************************************/
    else{
        return(0);
    }         
              
    return (1);  
               
}
//=============================================================================
// Timer1 overflow interrupt service routine
interrupt [TIM1_OVF] void timer1_ovf_isr(void)
{
    if(++milisec>=time_chaeck_const ) {
        if(++seconds>=60){
            if(++minutes>=60){
                
                if(++hours>=24){
                    hours=0; 
                    dev.day++;                 
                }
                else if(hours%2==0){
                    dev.hour = hours;
                }
                 minutes=0; 
                // ReadTemperatureBool = 10;  
            }              
            seconds=0;   
            temp_check++;
            
        } 
        milisec=0;  
         
    }

}
//=============================================================================
#ifndef _DEBUG_TERMINAL_IO_
// Get a character from the USART Receiver buffer
#pragma used+
char getchar(void)
{
    char data;
    while (rx_counter0==0);
    data=rx_buffer0[rx_rd_index0++];
    #if RX_BUFFER_SIZE0 != 256
    if (rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
    #endif
    #asm("cli")
    --rx_counter0;
    #asm("sei")
    return data;
}
#pragma used-
#endif
//=============================================================================
#ifndef _DEBUG_TERMINAL_IO_
// Write a character to the USART Transmitter buffer
#pragma used+
void putchar(char c)
{
    while (tx_counter0 == TX_BUFFER_SIZE0);
    #asm("cli")
    if (tx_counter0 || ((UCSR0A & DATA_REGISTER_EMPTY)==0))
       {
       tx_buffer0[tx_wr_index0++]=c;
    #if TX_BUFFER_SIZE0 != 256
       if (tx_wr_index0 == TX_BUFFER_SIZE0) tx_wr_index0=0;
    #endif
       ++tx_counter0;
       }
    else
       UDR0=c;
    #asm("sei")
}
#pragma used-
#endif
//=============================================================================
// USART Receiver interrupt service routine
interrupt [USART_RXC] void usart_rx_isr(void)
{
char status,data;
status=UCSR0A;
data=UDR0;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
   {
   rx_buffer0[rx_wr_index0++]=data;
#if RX_BUFFER_SIZE0 == 256
   // special case for receiver buffer size=256
   if (++rx_counter0 == 0) rx_buffer_overflow0=1;
#else
   if (rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
   if (++rx_counter0 == RX_BUFFER_SIZE0)
      {
      rx_counter0=0;
      rx_buffer_overflow0=1;
      }
#endif
   }
}
//=============================================================================
// USART Transmitter interrupt service routine
interrupt [USART_TXC] void usart_tx_isr(void)
{
if (tx_counter0)
   {
   --tx_counter0;
   UDR0=tx_buffer0[tx_rd_index0++];
#if TX_BUFFER_SIZE0 != 256
   if (tx_rd_index0 == TX_BUFFER_SIZE0) tx_rd_index0=0;
#endif
   }
}
//=============================================================================
void SendDevs(){
    unsigned char i;
    if (devices)
    {
        for (i=0;i<devices;i++)
        {
            delay_ms(10);
            sprintf(lcd_buffer,"D[%d]:%02X%02X%02X%02X%02X%02X%02X%02X\r\n"
            ,i
            ,rom_codes[i][0]
            ,rom_codes[i][1]
            ,rom_codes[i][2]
            ,rom_codes[i][3]
            ,rom_codes[i][4]
            ,rom_codes[i][5]
            ,rom_codes[i][6]
            ,rom_codes[i][7]);
            SendData(lcd_buffer);

        }
    }
}
//=============================================================================
void getData(char *data)
{
   // unsigned char recidev = 0;
    while(rx_counter0){
       *(data++) = getchar();
      // recidev++;
    }
    
}

//=============================================================================
void SendData(char *data)
{
    while(*data != 0)
    {
        putchar(*(data++));
        //delay_ms(1);
    } 
}
//=============================================================================
void InitilizeMC()
{
    // Crystal Oscillator division factor: 1
    #pragma optsize-
    CLKPR=0x80;
    CLKPR=0x00;
    #ifdef _OPTIMIZE_SIZE_
    #pragma optsize+
    #endif

    PORTA=0x00;
    DDRA=0x00;

    PORTB=0x00;
    DDRB=0x07;

    PORTC=0x00;
    DDRC=0x00;

    PORTD=0x00;
    DDRD=0x00;

    // Timer/Counter 0 initialization
    // Clock source: System Clock
    // Clock value: Timer 0 Stopped
    // Mode: Normal top=0xFF
    // OC0A output: Disconnected
    // OC0B output: Disconnected
    TCCR0A=0x00;
    TCCR0B=0x00;
    TCNT0=0x00;
    OCR0A=0x00;
    OCR0B=0x00;

    // Timer/Counter 1 initialization
    // Clock source: System Clock
    // Clock value: 8000,000 kHz
    // Mode: Normal top=0xFFFF
    // OC1A output: Discon.
    // OC1B output: Discon.
    // Noise Canceler: Off
    // Input Capture on Falling Edge
    // Timer1 Overflow Interrupt: On
    // Input Capture Interrupt: Off
    // Compare A Match Interrupt: Off
    // Compare B Match Interrupt: Off
    TCCR1A=0x00;
    TCCR1B=0x01;
    TCNT1H=0x00;
    TCNT1L=0x00;
    ICR1H=0x00;
    ICR1L=0x00;
    OCR1AH=0x00;
    OCR1AL=0x00;
    OCR1BH=0x00;
    OCR1BL=0x00;

    // Timer/Counter 2 initialization
    // Clock source: System Clock
    // Clock value: Timer2 Stopped
    // Mode: Normal top=0xFF
    // OC2A output: Disconnected
    // OC2B output: Disconnected
    ASSR=0x00;
    TCCR2A=0x00;
    TCCR2B=0x00;
    TCNT2=0x00;
    OCR2A=0x00;
    OCR2B=0x00;

    // External Interrupt(s) initialization
    // INT0: Off
    // INT1: Off
    // INT2: Off
    // Interrupt on any change on pins PCINT0-7: Off
    // Interrupt on any change on pins PCINT8-15: Off
    // Interrupt on any change on pins PCINT16-23: Off
    // Interrupt on any change on pins PCINT24-31: Off
    EICRA=0x00;
    EIMSK=0x00;
    PCICR=0x00;

    // Timer/Counter 0 Interrupt(s) initialization
    TIMSK0=0x00;

    // Timer/Counter 1 Interrupt(s) initialization
    TIMSK1=0x01;

    // Timer/Counter 2 Interrupt(s) initialization
    TIMSK2=0x00;

    // USART initialization
    // Communication Parameters: 8 Data, 1 Stop, No Parity
    // USART Receiver: On
    // USART Transmitter: On
    // USART0 Mode: Asynchronous
    // USART Baud Rate: 9600
    UCSR0A=0x00;
    UCSR0B=0xD8;
    UCSR0C=0x06;
    UBRR0H=0x00;
    UBRR0L=0x33;

    // Analog Comparator initialization
    // Analog Comparator: Off
    // Analog Comparator Input Capture by Timer/Counter 1: Off
    ACSR=0x80;
    ADCSRB=0x00;
    DIDR1=0x00;

    // ADC initialization
    // ADC disabled
    ADCSRA=0x00;

    // SPI initialization
    // SPI disabled
    SPCR=0x00;

    // TWI initialization
    // TWI disabled
    TWCR=0x00;
}
//=============================================================================
//=============================================================================
//=============================================================================