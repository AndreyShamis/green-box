#define GET_THEMPERATURE    "GT"
#define EEPROM_TEST         "ET"
#define THERMOMETERS_COUNT  "THCO"
#define SEND_LOCAL_TIME     "TM"
#define SEND_DEVICES_ID     "SD"
#define COMMAND_TEST        "TEST"
#define REFIND_DEVICES      "RT"
#define LIGHT_ENABLE        "LE"
#define LIGHT_DISABLE       "LD"
#define SEND_TIME_PREC      "STPR"
#define TIME_UPDATE_FULL    "TUF"
#define TIME_CHECK_CONST    "TC"

#define ENABLE_OBDUV            "ENOB"
#define ENABLE_VIDUV            "ENVI"
#define ENABLE_LIGHT           "ENLI"
#define DISABLE_OBDUV           "DIOB"
#define DISABLE_VIDUV           "DIVI"
#define DISABLE_LIGHT           "DILI"


#define PERIOD_A                'a'
#define PERIOD_B                'b'

#define SET_PERIOD              "SETPER"        //  Setting the period                      VALUES[0:1] 
#define SET_PERIOVD_POS         sizeof(SET_PERIOD)-1
#define SET_DAY_START           "SETDST"        //  Setting time (hour) when the day start  VALUES[0:23]
#define SET_DAY_START_POS       sizeof(SET_DAY_START) -1
#define SET_PERIOD_A_LEN        "SETPAL"        //  Setting period A day Length(Hours)
#define SET_PERIOD_A_LEN_POS    sizeof(SET_PERIOD_A_LEN) -1
#define SET_PERIOD_B_LEN        "SETPBL"        //  Setting period B day Length(Hours)
#define SET_PERIOD_B_LEN_POS    sizeof(SET_PERIOD_B_LEN)  -1
#define SET_DAY_NUMBER      "SETDNM"
#define SET_DAY_NUMBER_POS         sizeof(SET_DAY_NUMBER)-1

#define WRITE_HOUR_TO_EEPROM    "WRHRTOEP"
#define GET_PERIOD          "GETPER"
#define GET_DAY_START       "GETDST"
#define GET_PERIOD_A_LEN    "GETPAL"
#define GET_PERIOD_B_LEN    "GETPBL"
#define GET_OUTPUT_STATUS   "GETOPS"
#define GET_DAY_NUMBER      "GETDN"



#define CONTROL_LOCK        "LOCKC"
#define CONTROL_UNLOCK      "UNLOCKC"
#define AGRESIVE_TEMP_CHECK "AGRESTCH"















