
;CodeVisionAVR C Compiler V2.05.3 Professional
;(C) Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega644
;Program type             : Application
;Clock frequency          : 8,000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : float, width, precision
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 2048 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;Global 'const' stored in FLASH     : No
;Enhanced function parameter passing: Yes
;Enhanced core instructions         : On
;Smart register allocation          : On
;Automatic register allocation      : On

	#pragma AVRPART ADMIN PART_NAME ATmega644
	#pragma AVRPART MEMORY PROG_FLASH 65536
	#pragma AVRPART MEMORY EEPROM 2048
	#pragma AVRPART MEMORY INT_SRAM SIZE 4351
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x10FF
	.EQU __DSTACK_SIZE=0x0800
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _milisec=R4
	.DEF _hours=R3
	.DEF _minutes=R6
	.DEF _seconds=R5
	.DEF _time_chaeck_const=R8
	.DEF _devices=R7
	.DEF _temp_old_counter=R9
	.DEF _write_old_memory=R12
	.DEF _control_locker=R13
	.DEF _agresive_check=R11

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer1_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart_rx_isr
	JMP  0x00
	JMP  _usart_tx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_conv_delay_G102:
	.DB  0x64,0x0,0xC8,0x0,0x90,0x1,0x20,0x3
_bit_mask_G102:
	.DB  0xF8,0xFF,0xFC,0xFF,0xFE,0xFF,0xFF,0xFF

_0x3:
	.DB  0xD2
_0xC3:
	.DB  0x0,0x0,0x0,0x1,0x0,0x0
_0x0:
	.DB  0x46,0x6F,0x75,0x6E,0x64,0x20,0x25,0x64
	.DB  0x20,0x64,0x65,0x76,0x73,0xD,0xA,0x0
	.DB  0x4E,0x6F,0x74,0x20,0x46,0x6F,0x75,0x6E
	.DB  0x64,0x65,0x64,0xD,0xA,0x0,0x20,0x49
	.DB  0x6E,0x69,0x74,0x20,0x65,0x72,0x72,0x20
	.DB  0x25,0x75,0x20,0xD,0xA,0x0,0x53,0x54
	.DB  0x4F,0x50,0xD,0xA,0x0,0x57,0x41,0x52
	.DB  0x5B,0x25,0x64,0x5D,0x3A,0x25,0x66,0xD
	.DB  0xA,0x0,0x41,0x4C,0x45,0x5B,0x25,0x64
	.DB  0x5D,0x3A,0x25,0x66,0xD,0xA,0x0,0x4C
	.DB  0x49,0x4F,0x46,0x46,0x5B,0x25,0x64,0x5D
	.DB  0x3A,0x25,0x66,0xD,0xA,0x0,0x53,0x54
	.DB  0x41,0x52,0x54,0xD,0xA,0x0,0x47,0x54
	.DB  0x0,0x54,0x5B,0x25,0x64,0x5D,0x3A,0x25
	.DB  0x2E,0x33,0x66,0xD,0xA,0x0,0x54,0x48
	.DB  0x43,0x4F,0x0,0x54,0x43,0x3A,0x25,0x64
	.DB  0xD,0xA,0x0,0x54,0x4D,0x0,0x54,0x4D
	.DB  0x3A,0x25,0x64,0x3A,0x25,0x64,0x3A,0x25
	.DB  0x64,0xD,0xA,0x0,0x54,0x55,0x46,0x0
	.DB  0x53,0x44,0x0,0x45,0x4E,0x4F,0x42,0x0
	.DB  0x45,0x4E,0x56,0x49,0x0,0x45,0x4E,0x4C
	.DB  0x49,0x0,0x44,0x49,0x4F,0x42,0x0,0x44
	.DB  0x49,0x56,0x49,0x0,0x44,0x49,0x4C,0x49
	.DB  0x0,0x54,0x45,0x53,0x54,0x0,0x54,0x45
	.DB  0x53,0x54,0x3A,0x47,0x6F,0x6F,0x64,0x2E
	.DB  0xD,0xA,0x0,0x52,0x54,0x0,0x54,0x43
	.DB  0x0,0x53,0x54,0x50,0x52,0x0,0x53,0x54
	.DB  0x50,0x52,0x25,0x63,0xD,0xA,0x0,0x57
	.DB  0x52,0x48,0x52,0x54,0x4F,0x45,0x50,0x0
	.DB  0x47,0x45,0x54,0x44,0x4E,0x0,0x44,0x41
	.DB  0x59,0x4E,0x55,0x4D,0x42,0x45,0x52,0x3A
	.DB  0x25,0x64,0xD,0xA,0x0,0x41,0x47,0x52
	.DB  0x45,0x53,0x54,0x43,0x48,0x0,0x41,0x67
	.DB  0x72,0x65,0x73,0x69,0x76,0x65,0x20,0x54
	.DB  0x65,0x6D,0x70,0x20,0x43,0x68,0x65,0x63
	.DB  0x6B,0xD,0xA,0x0,0x4C,0x4F,0x43,0x4B
	.DB  0x43,0x0,0x55,0x6E,0x64,0x65,0x72,0x20
	.DB  0x43,0x6F,0x6E,0x74,0x72,0x6F,0x6C,0xD
	.DB  0xA,0x0,0x55,0x4E,0x4C,0x4F,0x43,0x4B
	.DB  0x43,0x0,0x41,0x75,0x74,0x6F,0x20,0x43
	.DB  0x6F,0x6E,0x74,0x72,0x6F,0x6C,0xD,0xA
	.DB  0x0,0x47,0x45,0x54,0x50,0x45,0x52,0x0
	.DB  0x50,0x45,0x52,0x49,0x4F,0x44,0x3A,0x25
	.DB  0x63,0xD,0xA,0x0,0x47,0x45,0x54,0x44
	.DB  0x53,0x54,0x0,0x44,0x41,0x59,0x2E,0x53
	.DB  0x54,0x3A,0x25,0x63,0xD,0xA,0x0,0x47
	.DB  0x45,0x54,0x50,0x41,0x4C,0x0,0x50,0x45
	.DB  0x52,0x2E,0x41,0x2E,0x3A,0x25,0x63,0xD
	.DB  0xA,0x0,0x47,0x45,0x54,0x50,0x42,0x4C
	.DB  0x0,0x50,0x45,0x52,0x2E,0x42,0x2E,0x3A
	.DB  0x25,0x63,0xD,0xA,0x0,0x47,0x45,0x54
	.DB  0x4F,0x50,0x53,0x0,0x47,0x45,0x54,0x4F
	.DB  0x50,0x53,0x3A,0x25,0x63,0x25,0x63,0x25
	.DB  0x63,0xD,0xA,0x0,0x53,0x45,0x54,0x44
	.DB  0x4E,0x4D,0x0,0x53,0x45,0x54,0x44,0x4E
	.DB  0x4D,0x3A,0x25,0x63,0xD,0xA,0x0,0x53
	.DB  0x45,0x54,0x50,0x45,0x52,0x0,0x53,0x45
	.DB  0x54,0x44,0x53,0x54,0x0,0x53,0x45,0x54
	.DB  0x50,0x41,0x4C,0x0,0x53,0x45,0x54,0x50
	.DB  0x42,0x4C,0x0,0x44,0x5B,0x25,0x64,0x5D
	.DB  0x3A,0x25,0x30,0x32,0x58,0x25,0x30,0x32
	.DB  0x58,0x25,0x30,0x32,0x58,0x25,0x30,0x32
	.DB  0x58,0x25,0x30,0x32,0x58,0x25,0x30,0x32
	.DB  0x58,0x25,0x30,0x32,0x58,0x25,0x30,0x32
	.DB  0x58,0xD,0xA,0x0
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0
_0x20A0060:
	.DB  0x1
_0x20A0000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  _temp_check
	.DW  _0x3*2

	.DW  0x01
	.DW  _0x33
	.DW  _0x0*2+15

	.DW  0x07
	.DW  _0x33+1
	.DW  _0x0*2+46

	.DW  0x08
	.DW  _0x33+8
	.DW  _0x0*2+94

	.DW  0x03
	.DW  _0x53
	.DW  _0x0*2+102

	.DW  0x05
	.DW  _0x53+3
	.DW  _0x0*2+118

	.DW  0x03
	.DW  _0x53+8
	.DW  _0x0*2+131

	.DW  0x04
	.DW  _0x53+11
	.DW  _0x0*2+148

	.DW  0x03
	.DW  _0x53+15
	.DW  _0x0*2+152

	.DW  0x05
	.DW  _0x53+18
	.DW  _0x0*2+155

	.DW  0x05
	.DW  _0x53+23
	.DW  _0x0*2+160

	.DW  0x05
	.DW  _0x53+28
	.DW  _0x0*2+165

	.DW  0x05
	.DW  _0x53+33
	.DW  _0x0*2+170

	.DW  0x05
	.DW  _0x53+38
	.DW  _0x0*2+175

	.DW  0x05
	.DW  _0x53+43
	.DW  _0x0*2+180

	.DW  0x05
	.DW  _0x53+48
	.DW  _0x0*2+185

	.DW  0x03
	.DW  _0x53+53
	.DW  _0x0*2+203

	.DW  0x03
	.DW  _0x53+56
	.DW  _0x0*2+206

	.DW  0x05
	.DW  _0x53+59
	.DW  _0x0*2+209

	.DW  0x09
	.DW  _0x53+64
	.DW  _0x0*2+223

	.DW  0x06
	.DW  _0x53+73
	.DW  _0x0*2+232

	.DW  0x09
	.DW  _0x53+79
	.DW  _0x0*2+253

	.DW  0x06
	.DW  _0x53+88
	.DW  _0x0*2+284

	.DW  0x08
	.DW  _0x53+94
	.DW  _0x0*2+306

	.DW  0x07
	.DW  _0x53+102
	.DW  _0x0*2+329

	.DW  0x07
	.DW  _0x53+109
	.DW  _0x0*2+348

	.DW  0x07
	.DW  _0x53+116
	.DW  _0x0*2+367

	.DW  0x07
	.DW  _0x53+123
	.DW  _0x0*2+386

	.DW  0x07
	.DW  _0x53+130
	.DW  _0x0*2+405

	.DW  0x07
	.DW  _0x53+137
	.DW  _0x0*2+428

	.DW  0x07
	.DW  _0x53+144
	.DW  _0x0*2+447

	.DW  0x07
	.DW  _0x53+151
	.DW  _0x0*2+454

	.DW  0x07
	.DW  _0x53+158
	.DW  _0x0*2+461

	.DW  0x07
	.DW  _0x53+165
	.DW  _0x0*2+468

	.DW  0x06
	.DW  0x09
	.DW  _0xC3*2

	.DW  0x01
	.DW  __seed_G105
	.DW  _0x20A0060*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x900

	.CSEG
;/***************************************************************************************************************
;****************************************************************************************************************
;****************************************************************************************************************
;        Chip type               : ATmega644
;        Program type            : Application
;        AVR Core Clock frequency: 8,000000 MHz
;        Memory model            : Small
;        External RAM size       : 0
;        Data Stack size         : 1024
;****************************************************************************************************************
;****************************************************************************************************************
;***************************************************************************************************************/
;//--------------------------- Include Section --------------------------------------------
;#include <mega644.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;#include <delay.h>
;#include <string.h>
;#include <stdio.h>
;#include <1wire.h>    // 1 Wire Bus interface functions
;#include <ds18b20.h>    // DS1820 Temperature Sensor functions
;#include "commands.h"
;
;//----------------------------   DEFINE SECTION ------------------------------------------
;
;#define CONTROL_FAN_OBDUV   PORTB.0
;#define CONTROL_FAN_VIDUV   PORTB.1
;#define CONTROL_LIGHT       PORTB.2
;#define ENABLE              1
;#define DISABLE             0
;
;#define     INPUT_SIZE      30
;#define     MAX_DS18B20     8       // maximum number of DS1820 devices connected to the 1 Wire bus
;#define     _TEMP_CHECK     2     //  Value for time for get temperature from thermometers
;#define     TIMER_PREC      122
;
;#define RX_BUFFER_SIZE0     INPUT_SIZE     // USART0 Receiver buffer
;#define TX_BUFFER_SIZE0     INPUT_SIZE
;
;#ifndef RXB8
;#define RXB8 1
;#endif
;#ifndef TXB8
;#define TXB8 0
;#endif
;#ifndef UPE
;#define UPE 2
;#endif
;#ifndef DOR
;#define DOR 3
;#endif
;#ifndef FE
;#define FE 4
;#endif
;#ifndef UDRE
;#define UDRE 5
;#endif
;#ifndef RXC
;#define RXC 7
;#endif
;
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<DOR)
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;//----------------------------   VARIAVBLE SECTION ---------------------------------------
;//eeprom char test;
;
;unsigned char milisec;
;unsigned char hours;
;unsigned char minutes;
;unsigned char seconds;
;unsigned char time_chaeck_const;
;unsigned char devices;                      // number of DS1820 devices connected to the 1 Wire bus
;unsigned char rom_codes[MAX_DS18B20][9];    // DS1820 devices ROM code storage area, 9 bytes are used for each device
;float temperature[MAX_DS18B20];
;
;#define WRITE_TRUE 20
;#define TEMP_OLD_SIZE 24*5
;char temperature_old[MAX_DS18B20][TEMP_OLD_SIZE];
;unsigned int temp_old_counter = 0;
;char write_old_memory = 1;
;char lcd_buffer[INPUT_SIZE];
;
;int control_locker = 0;
;unsigned char agresive_check = 0;
;char input_buffer[INPUT_SIZE];
;
;unsigned char temp_check = 210;

	.DSEG
;char rx_buffer0[RX_BUFFER_SIZE0];
;char tx_buffer0[TX_BUFFER_SIZE0];
;
;struct STAT_DEV{
;
;    unsigned char day ;
;    char period ;
;    unsigned char day_start;
;    unsigned char period_a_len;
;    unsigned char period_b_len;
;    unsigned char hour;
;} ;
;eeprom char offset1 = 0;
;eeprom char offset2 = 0;
;eeprom char offset3 = 0;
;eeprom struct STAT_DEV dev;
;//struct STAT_DEV devMEM;
;//===========================
;#if RX_BUFFER_SIZE0 <= 256
;unsigned char   rx_wr_index0,
;                rx_rd_index0,
;                rx_counter0;
;#else
;unsigned int    rx_wr_index0,
;                rx_rd_index0,
;                rx_counter0;
;#endif
;//===========================
;#if TX_BUFFER_SIZE0 <= 256
;unsigned char   tx_wr_index0,
;                tx_rd_index0,
;                tx_counter0;
;#else
;unsigned int    tx_wr_index0,
;                tx_rd_index0,
;                tx_counter0;
;#endif
;bit rx_buffer_overflow0;      // This flag is set on USART0 Receiver buffer overflow
;
;
;//=============================================================================
;interrupt [USART_RXC] void usart_rx_isr(void);
;interrupt [USART_TXC] void usart_tx_isr(void);
;interrupt [TIM1_OVF] void timer1_ovf_isr(void);
;#ifndef _DEBUG_TERMINAL_IO_
;    #define _ALTERNATE_GETCHAR_
;    #pragma used+
;    char getchar(void);         // Get a character from the USART Receiver buffer
;    #pragma used-
;#endif
;
;#ifndef _DEBUG_TERMINAL_IO_
;    #define _ALTERNATE_PUTCHAR_
;    #pragma used+
;    void putchar(char c);   // Write a character to the USART Transmitter buffer
;    #pragma used-
;#endif
;
;void SendData(char *data);
;void InitilizeMC();
;void getData(char *data);
;void SendDevs();
;char ScanCommand();
;char comcmp(char *comm,char *val);
;//=============================================================================
;void main(void)
; 0000 009B {

	.CSEG
_main:
; 0000 009C 
; 0000 009D    // unsigned char temp_check=_TEMP_CHECK;
; 0000 009E     unsigned char i;
; 0000 009F     unsigned char clearcommand = 0;
; 0000 00A0 
; 0000 00A1 
; 0000 00A2     InitilizeMC();
;	i -> R17
;	clearcommand -> R16
	LDI  R16,0
	RCALL _InitilizeMC
; 0000 00A3 
; 0000 00A4 
; 0000 00A5     if(dev.hour <24)
	__POINTW2MN _dev,5
	CALL __EEPROMRDB
	CPI  R30,LOW(0x18)
	BRSH _0x4
; 0000 00A6         hours = dev.hour;
	__POINTW2MN _dev,5
	CALL __EEPROMRDB
	MOV  R3,R30
; 0000 00A7 
; 0000 00A8     if(dev.period != PERIOD_A || dev.period != PERIOD_B)
_0x4:
	__POINTW2MN _dev,1
	CALL __EEPROMRDB
	CPI  R30,LOW(0x61)
	BRNE _0x6
	CPI  R30,LOW(0x62)
	BREQ _0x5
_0x6:
; 0000 00A9     {
; 0000 00AA         dev.period = PERIOD_A;
	__POINTW2MN _dev,1
	LDI  R30,LOW(97)
	CALL __EEPROMWRB
; 0000 00AB     }
; 0000 00AC 
; 0000 00AD     if(dev.day>250){
_0x5:
	CALL SUBOPT_0x0
	CPI  R30,LOW(0xFB)
	BRLO _0x8
; 0000 00AE         dev.day = 1;
	LDI  R26,LOW(_dev)
	LDI  R27,HIGH(_dev)
	LDI  R30,LOW(1)
	CALL __EEPROMWRB
; 0000 00AF     }
; 0000 00B0 
; 0000 00B1 
; 0000 00B2     if(dev.day_start > 23){
_0x8:
	CALL SUBOPT_0x1
	CPI  R30,LOW(0x18)
	BRLO _0x9
; 0000 00B3         dev.day_start = 6;
	__POINTW2MN _dev,2
	LDI  R30,LOW(6)
	CALL __EEPROMWRB
; 0000 00B4     }
; 0000 00B5 
; 0000 00B6     if(dev.period_a_len > 23){
_0x9:
	CALL SUBOPT_0x2
	CPI  R30,LOW(0x18)
	BRLO _0xA
; 0000 00B7         dev.period_a_len = 18 ;
	__POINTW2MN _dev,3
	LDI  R30,LOW(18)
	CALL __EEPROMWRB
; 0000 00B8     }
; 0000 00B9     if(dev.period_b_len > 23){
_0xA:
	CALL SUBOPT_0x3
	CPI  R30,LOW(0x18)
	BRLO _0xB
; 0000 00BA         dev.period_b_len = 12;
	__POINTW2MN _dev,4
	LDI  R30,LOW(12)
	CALL __EEPROMWRB
; 0000 00BB     }
; 0000 00BC 
; 0000 00BD     time_chaeck_const = TIMER_PREC;
_0xB:
	LDI  R30,LOW(122)
	MOV  R8,R30
; 0000 00BE     delay_ms(5000);
	LDI  R26,LOW(5000)
	LDI  R27,HIGH(5000)
	CALL _delay_ms
; 0000 00BF     w1_init();
	CALL SUBOPT_0x4
; 0000 00C0 
; 0000 00C1     // Determine the number of DS1820 devices connected to the 1 Wire bus
; 0000 00C2     devices=w1_search(0xf0,rom_codes);
; 0000 00C3     #asm("sei")             // Global enable interrupts
	sei
; 0000 00C4     if(devices){
	TST  R7
	BREQ _0xC
; 0000 00C5         sprintf(lcd_buffer,"Found %d devs\r\n",devices);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,0
	CALL SUBOPT_0x6
; 0000 00C6         SendData(lcd_buffer);
; 0000 00C7         SendDevs();
	RCALL _SendDevs
; 0000 00C8     }
; 0000 00C9     else{
	RJMP _0xD
_0xC:
; 0000 00CA         sprintf(lcd_buffer,"Not Founded\r\n");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,16
	CALL SUBOPT_0x7
; 0000 00CB         SendData(lcd_buffer);
; 0000 00CC     }
_0xD:
; 0000 00CD 
; 0000 00CE     for (i=0;i<devices;i++){
	LDI  R17,LOW(0)
_0xF:
	CP   R17,R7
	BRSH _0x10
; 0000 00CF         if (!ds18b20_init(&rom_codes[i][0],0,39,DS18B20_12BIT_RES)){
	CALL SUBOPT_0x8
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(39)
	ST   -Y,R30
	LDI  R26,LOW(3)
	CALL _ds18b20_init
	CPI  R30,0
	BRNE _0x11
; 0000 00D0            sprintf(lcd_buffer," Init err %u \r\n",i);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,30
	CALL SUBOPT_0x9
	CALL SUBOPT_0xA
; 0000 00D1            SendData(lcd_buffer);
; 0000 00D2         }
; 0000 00D3 
; 0000 00D4         delay_ms(100);
_0x11:
	LDI  R26,LOW(100)
	CALL SUBOPT_0xB
; 0000 00D5    }
	SUBI R17,-1
	RJMP _0xF
_0x10:
; 0000 00D6                CONTROL_FAN_OBDUV = ENABLE;
	SBI  0x5,0
; 0000 00D7                CONTROL_FAN_VIDUV = ENABLE;
	SBI  0x5,1
; 0000 00D8     while (1)
_0x16:
; 0000 00D9     {
; 0000 00DA 
; 0000 00DB 
; 0000 00DC         if(control_locker == 0)
	MOV  R0,R13
	OR   R0,R14
	BRNE _0x19
; 0000 00DD         {
; 0000 00DE             if(dev.period == PERIOD_A){
	CALL SUBOPT_0xC
	CPI  R30,LOW(0x61)
	BRNE _0x1A
; 0000 00DF                 if(hours >= dev.day_start && hours < (dev.day_start+dev.period_a_len)){
	CALL SUBOPT_0x1
	CP   R3,R30
	BRLO _0x1C
	MOV  R0,R30
	CLR  R1
	CALL SUBOPT_0x2
	CALL SUBOPT_0xD
	BRLT _0x1D
_0x1C:
	RJMP _0x1B
_0x1D:
; 0000 00E0                     CONTROL_LIGHT = ENABLE;
	SBI  0x5,2
; 0000 00E1                 }  else{
	RJMP _0x20
_0x1B:
; 0000 00E2                    CONTROL_LIGHT = DISABLE;
	CBI  0x5,2
; 0000 00E3                 }
_0x20:
; 0000 00E4             }
; 0000 00E5             else if(dev.period == PERIOD_B){
	RJMP _0x23
_0x1A:
	CALL SUBOPT_0xC
	CPI  R30,LOW(0x62)
	BRNE _0x24
; 0000 00E6                 if(hours >= dev.day_start && hours < (dev.day_start+dev.period_b_len)){
	CALL SUBOPT_0x1
	CP   R3,R30
	BRLO _0x26
	MOV  R0,R30
	CLR  R1
	CALL SUBOPT_0x3
	CALL SUBOPT_0xD
	BRLT _0x27
_0x26:
	RJMP _0x25
_0x27:
; 0000 00E7                     CONTROL_LIGHT = ENABLE;
	SBI  0x5,2
; 0000 00E8                 }  else{
	RJMP _0x2A
_0x25:
; 0000 00E9                    CONTROL_LIGHT = DISABLE;
	CBI  0x5,2
; 0000 00EA                 }
_0x2A:
; 0000 00EB             }
; 0000 00EC         }
_0x24:
_0x23:
; 0000 00ED         else{
	RJMP _0x2D
_0x19:
; 0000 00EE             control_locker++;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 13,14,30,31
; 0000 00EF             if(control_locker == 30000){
	LDI  R30,LOW(30000)
	LDI  R31,HIGH(30000)
	CP   R30,R13
	CPC  R31,R14
	BRNE _0x2E
; 0000 00F0                 control_locker = 0;
	CLR  R13
	CLR  R14
; 0000 00F1             }
; 0000 00F2         }
_0x2E:
_0x2D:
; 0000 00F3 
; 0000 00F4         //  Start check network data transfer
; 0000 00F5         getData(input_buffer);          //  Get trasfered data
	LDI  R26,LOW(_input_buffer)
	LDI  R27,HIGH(_input_buffer)
	RCALL _getData
; 0000 00F6 
; 0000 00F7         //  Every 30 minutes. Set variable for next temperature writing to memory on reading
; 0000 00F8         if(write_old_memory != WRITE_TRUE && minutes%30 == 0){
	LDI  R30,LOW(20)
	CP   R30,R12
	BREQ _0x30
	MOV  R26,R6
	CLR  R27
	LDI  R30,LOW(30)
	LDI  R31,HIGH(30)
	CALL __MODW21
	SBIW R30,0
	BREQ _0x31
_0x30:
	RJMP _0x2F
_0x31:
; 0000 00F9             write_old_memory = WRITE_TRUE;
	LDI  R30,LOW(20)
	MOV  R12,R30
; 0000 00FA         }
; 0000 00FB 
; 0000 00FC         if(strcmp(input_buffer,"")!=0)  //  Check if recived some data
_0x2F:
	CALL SUBOPT_0xE
	__POINTW2MN _0x33,0
	CALL _strcmp
	CPI  R30,0
	BREQ _0x32
; 0000 00FD         {
; 0000 00FE             if(ScanCommand()){          //  If recived command was executed
	RCALL _ScanCommand
	CPI  R30,0
	BREQ _0x34
; 0000 00FF                 clearcommand =200;
	LDI  R16,LOW(200)
; 0000 0100             }
; 0000 0101             else{
	RJMP _0x35
_0x34:
; 0000 0102                 clearcommand++;         //  else encrease counter for fix command from sender
	SUBI R16,-1
; 0000 0103             }
_0x35:
; 0000 0104             //  Maximum sender can fix-comlite command in 3 trys.
; 0000 0105             if(clearcommand >=3){
	CPI  R16,3
	BRLO _0x36
; 0000 0106                 memset(input_buffer,'\0',INPUT_SIZE);
	CALL SUBOPT_0xE
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(30)
	LDI  R27,0
	CALL _memset
; 0000 0107                 clearcommand =0;
	LDI  R16,LOW(0)
; 0000 0108             }
; 0000 0109         }
_0x36:
; 0000 010A         else{
	RJMP _0x37
_0x32:
; 0000 010B             if(temp_check >= _TEMP_CHECK || agresive_check==1){
	LDS  R26,_temp_check
	CPI  R26,LOW(0x2)
	BRSH _0x39
	LDI  R30,LOW(1)
	CP   R30,R11
	BREQ _0x39
	RJMP _0x38
_0x39:
; 0000 010C             agresive_check=0;
	CLR  R11
; 0000 010D             temp_check = 1;
	LDI  R30,LOW(1)
	STS  _temp_check,R30
; 0000 010E                  SendData("STOP\r\n");
	__POINTW2MN _0x33,1
	RCALL _SendData
; 0000 010F                 for (i=0;i<devices;i++)
	LDI  R17,LOW(0)
_0x3C:
	CP   R17,R7
	BRLO PC+3
	JMP _0x3D
; 0000 0110                 {
; 0000 0111                     temperature[i] =  ds18b20_temperature(&rom_codes[i][0]);
	CALL SUBOPT_0xF
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x8
	MOVW R26,R30
	CALL _ds18b20_temperature
	POP  R26
	POP  R27
	CALL __PUTDP1
; 0000 0112                     if(temperature[i]>=45 && temperature[i] <52){
	CALL SUBOPT_0xF
	CALL SUBOPT_0x10
	__GETD1N 0x42340000
	CALL __CMPF12
	BRLO _0x3F
	CALL SUBOPT_0xF
	CALL SUBOPT_0x10
	CALL SUBOPT_0x11
	BRLO _0x40
_0x3F:
	RJMP _0x3E
_0x40:
; 0000 0113                         sprintf(lcd_buffer,"WAR[%d]:%f\r\n",i,temperature[i]);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,53
	RJMP _0xC1
; 0000 0114                         SendData(lcd_buffer);
; 0000 0115                     }
; 0000 0116                     else if(temperature[i]>=52 && temperature[i] <66){
_0x3E:
	CALL SUBOPT_0xF
	CALL SUBOPT_0x10
	CALL SUBOPT_0x11
	BRLO _0x43
	CALL SUBOPT_0xF
	CALL SUBOPT_0x10
	CALL SUBOPT_0x12
	BRLO _0x44
_0x43:
	RJMP _0x42
_0x44:
; 0000 0117                         sprintf(lcd_buffer,"ALE[%d]:%f\r\n",i,temperature[i]);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,66
	RJMP _0xC1
; 0000 0118                         SendData(lcd_buffer);
; 0000 0119                     }
; 0000 011A                     else if(temperature[i]>=66)
_0x42:
	CALL SUBOPT_0xF
	CALL SUBOPT_0x10
	CALL SUBOPT_0x12
	BRLO _0x46
; 0000 011B                     {
; 0000 011C                         CONTROL_LIGHT = DISABLE;
	CBI  0x5,2
; 0000 011D                         sprintf(lcd_buffer,"LIOFF[%d]:%f\r\n",i,temperature[i]);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,79
_0xC1:
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R17
	CALL SUBOPT_0x13
	CALL SUBOPT_0xF
	CALL SUBOPT_0x14
	CALL SUBOPT_0x15
; 0000 011E                         SendData(lcd_buffer);
; 0000 011F                     }
; 0000 0120                     if(write_old_memory == WRITE_TRUE){
_0x46:
	LDI  R30,LOW(20)
	CP   R30,R12
	BRNE _0x49
; 0000 0121                         temperature_old[i][temp_old_counter] =  (int) temperature[i];
	LDI  R26,LOW(120)
	MUL  R17,R26
	MOVW R30,R0
	SUBI R30,LOW(-_temperature_old)
	SBCI R31,HIGH(-_temperature_old)
	ADD  R30,R9
	ADC  R31,R10
	MOVW R24,R30
	CALL SUBOPT_0xF
	CALL SUBOPT_0x14
	CALL __CFD1
	MOVW R26,R24
	ST   X,R30
; 0000 0122                     }
; 0000 0123                     delay_ms(5);
_0x49:
	LDI  R26,LOW(5)
	CALL SUBOPT_0xB
; 0000 0124                 }
	SUBI R17,-1
	RJMP _0x3C
_0x3D:
; 0000 0125                 if(write_old_memory == WRITE_TRUE){
	LDI  R30,LOW(20)
	CP   R30,R12
	BRNE _0x4A
; 0000 0126                       temp_old_counter++;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 9,10,30,31
; 0000 0127                       write_old_memory =0;
	CLR  R12
; 0000 0128                 }
; 0000 0129               if(temp_old_counter == TEMP_OLD_SIZE){
_0x4A:
	LDI  R30,LOW(120)
	LDI  R31,HIGH(120)
	CP   R30,R9
	CPC  R31,R10
	BRNE _0x4B
; 0000 012A                      temp_old_counter = 0;
	CLR  R9
	CLR  R10
; 0000 012B               }
; 0000 012C                 SendData("START\r\n");
_0x4B:
	__POINTW2MN _0x33,8
	RCALL _SendData
; 0000 012D             }
; 0000 012E         }
_0x38:
_0x37:
; 0000 012F         //  End Check network data transfer
; 0000 0130 
; 0000 0131         delay_ms(50);
	LDI  R26,LOW(50)
	CALL SUBOPT_0xB
; 0000 0132     }
	RJMP _0x16
; 0000 0133 }
_0x4C:
	RJMP _0x4C

	.DSEG
_0x33:
	.BYTE 0x10
;//=============================================================================
;char comcmp(char *comm,char *val){
; 0000 0135 char comcmp(char *comm,char *val){

	.CSEG
_comcmp:
; 0000 0136     unsigned char counter=0;
; 0000 0137     unsigned char lencom = strlen(comm);
; 0000 0138     unsigned char length=strlen(val);
; 0000 0139 
; 0000 013A     if(lencom <length )  {
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
;	*comm -> Y+6
;	*val -> Y+4
;	counter -> R17
;	lencom -> R16
;	length -> R19
	LDI  R17,0
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CALL _strlen
	MOV  R16,R30
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL _strlen
	MOV  R19,R30
	CP   R16,R19
	BRSH _0x4D
; 0000 013B         return 0;
	LDI  R30,LOW(0)
	RJMP _0x20C000B
; 0000 013C     }
; 0000 013D     for(counter=0;counter<length;counter++){
_0x4D:
	LDI  R17,LOW(0)
_0x4F:
	CP   R17,R19
	BRSH _0x50
; 0000 013E         if(comm[counter] != val[counter] )
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CLR  R30
	ADD  R26,R17
	ADC  R27,R30
	LD   R0,X
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CLR  R30
	ADD  R26,R17
	ADC  R27,R30
	LD   R30,X
	CP   R30,R0
	BREQ _0x51
; 0000 013F         {
; 0000 0140             return 0;
	LDI  R30,LOW(0)
	RJMP _0x20C000B
; 0000 0141         }
; 0000 0142     }
_0x51:
	SUBI R17,-1
	RJMP _0x4F
_0x50:
; 0000 0143     return 1;
	LDI  R30,LOW(1)
_0x20C000B:
	CALL __LOADLOCR4
	ADIW R28,8
	RET
; 0000 0144 }
;//=============================================================================
;char ScanCommand(){
; 0000 0146 char ScanCommand(){
_ScanCommand:
; 0000 0147     unsigned char i;
; 0000 0148 
; 0000 0149     if(strcmp(input_buffer,GET_THEMPERATURE)==0){
	ST   -Y,R17
;	i -> R17
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,0
	CALL _strcmp
	CPI  R30,0
	BRNE _0x52
; 0000 014A         for (i=0;i<devices;i++){
	LDI  R17,LOW(0)
_0x55:
	CP   R17,R7
	BRSH _0x56
; 0000 014B             sprintf(lcd_buffer,"T[%d]:%.3f\r\n",i,temperature[i]);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,105
	CALL SUBOPT_0x9
	CALL SUBOPT_0xF
	CALL SUBOPT_0x14
	CALL SUBOPT_0x15
; 0000 014C             SendData(lcd_buffer);
; 0000 014D             delay_ms(40);          // 40
	LDI  R26,LOW(40)
	CALL SUBOPT_0xB
; 0000 014E         }
	SUBI R17,-1
	RJMP _0x55
_0x56:
; 0000 014F     }
; 0000 0150     else if(strcmp(input_buffer,THERMOMETERS_COUNT)==0){
	RJMP _0x57
_0x52:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,3
	CALL _strcmp
	CPI  R30,0
	BRNE _0x58
; 0000 0151         sprintf(lcd_buffer,"TC:%d\r\n",devices);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,123
	CALL SUBOPT_0x6
; 0000 0152         SendData(lcd_buffer);
; 0000 0153     }
; 0000 0154     else if (strcmp(input_buffer,SEND_LOCAL_TIME)==0){
	RJMP _0x59
_0x58:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,8
	CALL _strcmp
	CPI  R30,0
	BRNE _0x5A
; 0000 0155         sprintf(lcd_buffer,"TM:%d:%d:%d\r\n",hours,minutes,seconds);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,134
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R3
	CALL SUBOPT_0x13
	MOV  R30,R6
	CALL SUBOPT_0x13
	MOV  R30,R5
	CALL SUBOPT_0x13
	CALL SUBOPT_0x16
; 0000 0156         SendData(lcd_buffer);
; 0000 0157     }
; 0000 0158     else if (comcmp(input_buffer,TIME_UPDATE_FULL)){
	RJMP _0x5B
_0x5A:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,11
	RCALL _comcmp
	CPI  R30,0
	BREQ _0x5C
; 0000 0159         hours       = input_buffer[3]-50;
	__GETB1MN _input_buffer,3
	SUBI R30,LOW(50)
	MOV  R3,R30
; 0000 015A         minutes     = input_buffer[4]-50;
	__GETB1MN _input_buffer,4
	SUBI R30,LOW(50)
	MOV  R6,R30
; 0000 015B         seconds     = input_buffer[5]-50;
	__GETB1MN _input_buffer,5
	SUBI R30,LOW(50)
	MOV  R5,R30
; 0000 015C     }
; 0000 015D     else if(strcmp(input_buffer,SEND_DEVICES_ID)==0){
	RJMP _0x5D
_0x5C:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,15
	CALL _strcmp
	CPI  R30,0
	BRNE _0x5E
; 0000 015E         SendDevs();
	RCALL _SendDevs
; 0000 015F     }
; 0000 0160     else if(strcmp(input_buffer,ENABLE_OBDUV)==0){
	RJMP _0x5F
_0x5E:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,18
	CALL _strcmp
	CPI  R30,0
	BRNE _0x60
; 0000 0161         CONTROL_FAN_OBDUV = ENABLE;
	SBI  0x5,0
; 0000 0162     }
; 0000 0163      else if(strcmp(input_buffer,ENABLE_VIDUV)==0){
	RJMP _0x63
_0x60:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,23
	CALL _strcmp
	CPI  R30,0
	BRNE _0x64
; 0000 0164         CONTROL_FAN_VIDUV = ENABLE;
	SBI  0x5,1
; 0000 0165     }
; 0000 0166     else if(strcmp(input_buffer,ENABLE_LIGHT)==0){
	RJMP _0x67
_0x64:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,28
	CALL _strcmp
	CPI  R30,0
	BRNE _0x68
; 0000 0167         CONTROL_LIGHT = ENABLE;
	SBI  0x5,2
; 0000 0168     }
; 0000 0169     else if(strcmp(input_buffer,DISABLE_OBDUV)==0){
	RJMP _0x6B
_0x68:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,33
	CALL _strcmp
	CPI  R30,0
	BRNE _0x6C
; 0000 016A         CONTROL_FAN_OBDUV = DISABLE;
	CBI  0x5,0
; 0000 016B     }
; 0000 016C      else if(strcmp(input_buffer,DISABLE_VIDUV)==0){
	RJMP _0x6F
_0x6C:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,38
	CALL _strcmp
	CPI  R30,0
	BRNE _0x70
; 0000 016D 
; 0000 016E         CONTROL_FAN_VIDUV = DISABLE;
	CBI  0x5,1
; 0000 016F     }
; 0000 0170     else if(strcmp(input_buffer,DISABLE_LIGHT)==0){
	RJMP _0x73
_0x70:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,43
	CALL _strcmp
	CPI  R30,0
	BRNE _0x74
; 0000 0171         CONTROL_LIGHT = DISABLE;
	CBI  0x5,2
; 0000 0172     }
; 0000 0173     else if(strcmp(input_buffer,COMMAND_TEST)==0) {
	RJMP _0x77
_0x74:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,48
	CALL _strcmp
	CPI  R30,0
	BRNE _0x78
; 0000 0174         sprintf(lcd_buffer,"TEST:Good.\r\n");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,190
	CALL SUBOPT_0x7
; 0000 0175         SendData(lcd_buffer);
; 0000 0176     }
; 0000 0177     else if(strcmp(input_buffer,REFIND_DEVICES)==0){
	RJMP _0x79
_0x78:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,53
	CALL _strcmp
	CPI  R30,0
	BRNE _0x7A
; 0000 0178         w1_init();
	CALL SUBOPT_0x4
; 0000 0179         devices=w1_search(0xf0,rom_codes);
; 0000 017A         sprintf(lcd_buffer,"TC:%d\r\n",devices);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,123
	CALL SUBOPT_0x6
; 0000 017B         SendData(lcd_buffer);
; 0000 017C     }
; 0000 017D     else if(comcmp(input_buffer,TIME_CHECK_CONST)){
	RJMP _0x7B
_0x7A:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,56
	RCALL _comcmp
	CPI  R30,0
	BREQ _0x7C
; 0000 017E 
; 0000 017F         time_chaeck_const = input_buffer[2];
	__GETBRMN 8,_input_buffer,2
; 0000 0180     }
; 0000 0181     else if(strcmp(input_buffer, SEND_TIME_PREC)==0){
	RJMP _0x7D
_0x7C:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,59
	CALL _strcmp
	CPI  R30,0
	BRNE _0x7E
; 0000 0182         sprintf(lcd_buffer,"STPR%c\r\n",time_chaeck_const);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,214
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R8
	CALL SUBOPT_0x13
	CALL SUBOPT_0xA
; 0000 0183         SendData(lcd_buffer);
; 0000 0184     }
; 0000 0185     else if(strcmp(input_buffer,WRITE_HOUR_TO_EEPROM )==0) {
	RJMP _0x7F
_0x7E:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,64
	CALL _strcmp
	CPI  R30,0
	BRNE _0x80
; 0000 0186         dev.hour = hours;
	__POINTW2MN _dev,5
	MOV  R30,R3
	CALL __EEPROMWRB
; 0000 0187     }
; 0000 0188     else if(strcmp(input_buffer,GET_DAY_NUMBER )==0) {
	RJMP _0x81
_0x80:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,73
	CALL _strcmp
	CPI  R30,0
	BRNE _0x82
; 0000 0189         sprintf(lcd_buffer,"DAYNUMBER:%d\r\n",dev.day);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,238
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x0
	CALL SUBOPT_0x13
	CALL SUBOPT_0xA
; 0000 018A         SendData(lcd_buffer);
; 0000 018B     }
; 0000 018C     else if(strcmp(input_buffer,AGRESIVE_TEMP_CHECK )==0) {
	RJMP _0x83
_0x82:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,79
	CALL _strcmp
	CPI  R30,0
	BRNE _0x84
; 0000 018D         agresive_check = 1;
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0000 018E         sprintf(lcd_buffer,"Agresive Temp Check\r\n");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,262
	CALL SUBOPT_0x7
; 0000 018F         SendData(lcd_buffer);
; 0000 0190     }
; 0000 0191     else if(strcmp(input_buffer,CONTROL_LOCK )==0) {
	RJMP _0x85
_0x84:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,88
	CALL _strcmp
	CPI  R30,0
	BRNE _0x86
; 0000 0192         control_locker = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__PUTW1R 13,14
; 0000 0193         sprintf(lcd_buffer,"Under Control\r\n");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,290
	CALL SUBOPT_0x7
; 0000 0194         SendData(lcd_buffer);
; 0000 0195     }
; 0000 0196     else if(strcmp(input_buffer,CONTROL_UNLOCK )==0) {
	RJMP _0x87
_0x86:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,94
	CALL _strcmp
	CPI  R30,0
	BRNE _0x88
; 0000 0197         control_locker = 0;
	CLR  R13
	CLR  R14
; 0000 0198         sprintf(lcd_buffer,"Auto Control\r\n");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,314
	CALL SUBOPT_0x7
; 0000 0199         SendData(lcd_buffer);
; 0000 019A     }
; 0000 019B     /**************************************************/
; 0000 019C     /**************************************************/
; 0000 019D     else if(strcmp(input_buffer,GET_PERIOD )==0) {
	RJMP _0x89
_0x88:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,102
	CALL _strcmp
	CPI  R30,0
	BRNE _0x8A
; 0000 019E         sprintf(lcd_buffer,"PERIOD:%c\r\n",dev.period);
	CALL SUBOPT_0x5
	CALL SUBOPT_0x17
	CALL SUBOPT_0x13
	CALL SUBOPT_0xA
; 0000 019F         SendData(lcd_buffer);
; 0000 01A0     }
; 0000 01A1     else if(strcmp(input_buffer,GET_DAY_START )==0) {
	RJMP _0x8B
_0x8A:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,109
	CALL _strcmp
	CPI  R30,0
	BRNE _0x8C
; 0000 01A2         sprintf(lcd_buffer,"DAY.ST:%c\r\n",dev.day_start);
	CALL SUBOPT_0x5
	CALL SUBOPT_0x18
	CALL SUBOPT_0x13
	CALL SUBOPT_0xA
; 0000 01A3         SendData(lcd_buffer);
; 0000 01A4     }
; 0000 01A5     else if(strcmp(input_buffer,GET_PERIOD_A_LEN )==0) {
	RJMP _0x8D
_0x8C:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,116
	CALL _strcmp
	CPI  R30,0
	BRNE _0x8E
; 0000 01A6         sprintf(lcd_buffer,"PER.A.:%c\r\n", dev.period_a_len);
	CALL SUBOPT_0x5
	CALL SUBOPT_0x19
	CALL SUBOPT_0x13
	CALL SUBOPT_0xA
; 0000 01A7         SendData(lcd_buffer);
; 0000 01A8     }
; 0000 01A9     else if(strcmp(input_buffer,GET_PERIOD_B_LEN )==0) {
	RJMP _0x8F
_0x8E:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,123
	CALL _strcmp
	CPI  R30,0
	BRNE _0x90
; 0000 01AA         sprintf(lcd_buffer,"PER.B.:%c\r\n",dev.period_b_len);
	CALL SUBOPT_0x5
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x13
	CALL SUBOPT_0xA
; 0000 01AB         SendData(lcd_buffer);
; 0000 01AC     }
; 0000 01AD     else if(strcmp(input_buffer,GET_OUTPUT_STATUS )==0) {
	RJMP _0x91
_0x90:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,130
	CALL _strcmp
	CPI  R30,0
	BRNE _0x92
; 0000 01AE         sprintf(lcd_buffer,"GETOPS:%c%c%c\r\n",PORTB.0+48,PORTB.1+48,PORTB.2+48);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,412
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,0
	SBIC 0x5,0
	LDI  R30,1
	SUBI R30,-LOW(48)
	CALL SUBOPT_0x13
	LDI  R30,0
	SBIC 0x5,1
	LDI  R30,1
	SUBI R30,-LOW(48)
	CALL SUBOPT_0x13
	LDI  R30,0
	SBIC 0x5,2
	LDI  R30,1
	SUBI R30,-LOW(48)
	CALL SUBOPT_0x13
	CALL SUBOPT_0x16
; 0000 01AF         SendData(lcd_buffer);
; 0000 01B0     }
; 0000 01B1 
; 0000 01B2 
; 0000 01B3     /**************************************************/
; 0000 01B4     /**************************************************/
; 0000 01B5     else if(comcmp(input_buffer,SET_DAY_NUMBER )) {
	RJMP _0x93
_0x92:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,137
	RCALL _comcmp
	CPI  R30,0
	BREQ _0x94
; 0000 01B6         dev.day =  input_buffer[SET_DAY_NUMBER_POS];
	__GETB1MN _input_buffer,6
	LDI  R26,LOW(_dev)
	LDI  R27,HIGH(_dev)
	CALL SUBOPT_0x1B
; 0000 01B7         sprintf(lcd_buffer,"SETDNM:%c\r\n",dev.day);
	__POINTW1FN _0x0,435
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x0
	CALL SUBOPT_0x13
	CALL SUBOPT_0xA
; 0000 01B8         SendData(lcd_buffer);
; 0000 01B9     }
; 0000 01BA     else if(comcmp(input_buffer,SET_PERIOD )) {
	RJMP _0x95
_0x94:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,144
	RCALL _comcmp
	CPI  R30,0
	BREQ _0x96
; 0000 01BB         dev.period =  input_buffer[SET_PERIOVD_POS];
	__POINTW2MN _dev,1
	CALL SUBOPT_0x1C
; 0000 01BC         sprintf(lcd_buffer,"PERIOD:%c\r\n",dev.period);
	CALL SUBOPT_0x17
	CALL SUBOPT_0x13
	CALL SUBOPT_0xA
; 0000 01BD         SendData(lcd_buffer);
; 0000 01BE     }
; 0000 01BF     else if(comcmp(input_buffer,SET_DAY_START )) {
	RJMP _0x97
_0x96:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,151
	RCALL _comcmp
	CPI  R30,0
	BREQ _0x98
; 0000 01C0         dev.day_start   =  input_buffer[SET_DAY_START_POS];
	__POINTW2MN _dev,2
	CALL SUBOPT_0x1C
; 0000 01C1         sprintf(lcd_buffer,"DAY.ST:%c\r\n",dev.day_start);
	CALL SUBOPT_0x18
	CALL SUBOPT_0x13
	CALL SUBOPT_0xA
; 0000 01C2         SendData(lcd_buffer);
; 0000 01C3     }
; 0000 01C4     else if(comcmp(input_buffer,SET_PERIOD_A_LEN )) {
	RJMP _0x99
_0x98:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,158
	RCALL _comcmp
	CPI  R30,0
	BREQ _0x9A
; 0000 01C5         dev.period_a_len   =  input_buffer[SET_PERIOD_A_LEN_POS];
	__POINTW2MN _dev,3
	CALL SUBOPT_0x1C
; 0000 01C6         sprintf(lcd_buffer,"PER.A.:%c\r\n", dev.period_a_len);
	CALL SUBOPT_0x19
	CALL SUBOPT_0x13
	CALL SUBOPT_0xA
; 0000 01C7         SendData(lcd_buffer);
; 0000 01C8     }
; 0000 01C9     else if(comcmp(input_buffer,SET_PERIOD_B_LEN )) {
	RJMP _0x9B
_0x9A:
	CALL SUBOPT_0xE
	__POINTW2MN _0x53,165
	RCALL _comcmp
	CPI  R30,0
	BREQ _0x9C
; 0000 01CA         dev.period_b_len   =  input_buffer[SET_PERIOD_B_LEN_POS];
	__POINTW2MN _dev,4
	CALL SUBOPT_0x1C
; 0000 01CB         sprintf(lcd_buffer,"PER.B.:%c\r\n",dev.period_b_len);
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x13
	CALL SUBOPT_0xA
; 0000 01CC         SendData(lcd_buffer);
; 0000 01CD     }
; 0000 01CE     /**************************************************/
; 0000 01CF     /**************************************************/
; 0000 01D0     else{
	RJMP _0x9D
_0x9C:
; 0000 01D1         return(0);
	LDI  R30,LOW(0)
	RJMP _0x20C000A
; 0000 01D2     }
_0x9D:
_0x9B:
_0x99:
_0x97:
_0x95:
_0x93:
_0x91:
_0x8F:
_0x8D:
_0x8B:
_0x89:
_0x87:
_0x85:
_0x83:
_0x81:
_0x7F:
_0x7D:
_0x7B:
_0x79:
_0x77:
_0x73:
_0x6F:
_0x6B:
_0x67:
_0x63:
_0x5F:
_0x5D:
_0x5B:
_0x59:
_0x57:
; 0000 01D3 
; 0000 01D4     return (1);
	LDI  R30,LOW(1)
	RJMP _0x20C000A
; 0000 01D5 
; 0000 01D6 }

	.DSEG
_0x53:
	.BYTE 0xAC
;//=============================================================================
;// Timer1 overflow interrupt service routine
;interrupt [TIM1_OVF] void timer1_ovf_isr(void)
; 0000 01DA {

	.CSEG
_timer1_ovf_isr:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 01DB     if(++milisec>=time_chaeck_const ) {
	INC  R4
	CP   R4,R8
	BRLO _0x9E
; 0000 01DC         if(++seconds>=60){
	INC  R5
	LDI  R30,LOW(60)
	CP   R5,R30
	BRLO _0x9F
; 0000 01DD             if(++minutes>=60){
	INC  R6
	CP   R6,R30
	BRLO _0xA0
; 0000 01DE 
; 0000 01DF                 if(++hours>=24){
	INC  R3
	LDI  R30,LOW(24)
	CP   R3,R30
	BRLO _0xA1
; 0000 01E0                     hours=0;
	CLR  R3
; 0000 01E1                     dev.day++;
	CALL SUBOPT_0x0
	SUBI R30,-LOW(1)
	CALL __EEPROMWRB
	SUBI R30,LOW(1)
; 0000 01E2                 }
; 0000 01E3                 else if(hours%2==0){
	RJMP _0xA2
_0xA1:
	MOV  R26,R3
	CLR  R27
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL __MODW21
	SBIW R30,0
	BRNE _0xA3
; 0000 01E4                     dev.hour = hours;
	__POINTW2MN _dev,5
	MOV  R30,R3
	CALL __EEPROMWRB
; 0000 01E5                 }
; 0000 01E6                  minutes=0;
_0xA3:
_0xA2:
	CLR  R6
; 0000 01E7                 // ReadTemperatureBool = 10;
; 0000 01E8             }
; 0000 01E9             seconds=0;
_0xA0:
	CLR  R5
; 0000 01EA             temp_check++;
	LDS  R30,_temp_check
	SUBI R30,-LOW(1)
	STS  _temp_check,R30
; 0000 01EB 
; 0000 01EC         }
; 0000 01ED         milisec=0;
_0x9F:
	CLR  R4
; 0000 01EE 
; 0000 01EF     }
; 0000 01F0 
; 0000 01F1 }
_0x9E:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
;//=============================================================================
;#ifndef _DEBUG_TERMINAL_IO_
;// Get a character from the USART Receiver buffer
;#pragma used+
;char getchar(void)
; 0000 01F7 {
_getchar:
; 0000 01F8     char data;
; 0000 01F9     while (rx_counter0==0);
	ST   -Y,R17
;	data -> R17
_0xA4:
	LDS  R30,_rx_counter0
	CPI  R30,0
	BREQ _0xA4
; 0000 01FA     data=rx_buffer0[rx_rd_index0++];
	LDS  R30,_rx_rd_index0
	SUBI R30,-LOW(1)
	STS  _rx_rd_index0,R30
	CALL SUBOPT_0x1D
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	LD   R17,Z
; 0000 01FB     #if RX_BUFFER_SIZE0 != 256
; 0000 01FC     if (rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
	LDS  R26,_rx_rd_index0
	CPI  R26,LOW(0x1E)
	BRNE _0xA7
	LDI  R30,LOW(0)
	STS  _rx_rd_index0,R30
; 0000 01FD     #endif
; 0000 01FE     #asm("cli")
_0xA7:
	cli
; 0000 01FF     --rx_counter0;
	LDS  R30,_rx_counter0
	SUBI R30,LOW(1)
	STS  _rx_counter0,R30
; 0000 0200     #asm("sei")
	sei
; 0000 0201     return data;
	MOV  R30,R17
	RJMP _0x20C000A
; 0000 0202 }
;#pragma used-
;#endif
;//=============================================================================
;#ifndef _DEBUG_TERMINAL_IO_
;// Write a character to the USART Transmitter buffer
;#pragma used+
;void putchar(char c)
; 0000 020A {
_putchar:
; 0000 020B     while (tx_counter0 == TX_BUFFER_SIZE0);
	ST   -Y,R26
;	c -> Y+0
_0xA8:
	LDS  R26,_tx_counter0
	CPI  R26,LOW(0x1E)
	BREQ _0xA8
; 0000 020C     #asm("cli")
	cli
; 0000 020D     if (tx_counter0 || ((UCSR0A & DATA_REGISTER_EMPTY)==0))
	LDS  R30,_tx_counter0
	CPI  R30,0
	BRNE _0xAC
	LDS  R30,192
	ANDI R30,LOW(0x20)
	BRNE _0xAB
_0xAC:
; 0000 020E        {
; 0000 020F        tx_buffer0[tx_wr_index0++]=c;
	LDS  R30,_tx_wr_index0
	SUBI R30,-LOW(1)
	STS  _tx_wr_index0,R30
	CALL SUBOPT_0x1D
	SUBI R30,LOW(-_tx_buffer0)
	SBCI R31,HIGH(-_tx_buffer0)
	LD   R26,Y
	STD  Z+0,R26
; 0000 0210     #if TX_BUFFER_SIZE0 != 256
; 0000 0211        if (tx_wr_index0 == TX_BUFFER_SIZE0) tx_wr_index0=0;
	LDS  R26,_tx_wr_index0
	CPI  R26,LOW(0x1E)
	BRNE _0xAE
	LDI  R30,LOW(0)
	STS  _tx_wr_index0,R30
; 0000 0212     #endif
; 0000 0213        ++tx_counter0;
_0xAE:
	LDS  R30,_tx_counter0
	SUBI R30,-LOW(1)
	STS  _tx_counter0,R30
; 0000 0214        }
; 0000 0215     else
	RJMP _0xAF
_0xAB:
; 0000 0216        UDR0=c;
	LD   R30,Y
	STS  198,R30
; 0000 0217     #asm("sei")
_0xAF:
	sei
; 0000 0218 }
	ADIW R28,1
	RET
;#pragma used-
;#endif
;//=============================================================================
;// USART Receiver interrupt service routine
;interrupt [USART_RXC] void usart_rx_isr(void)
; 0000 021E {
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 021F char status,data;
; 0000 0220 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	LDS  R17,192
; 0000 0221 data=UDR0;
	LDS  R16,198
; 0000 0222 if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0xB0
; 0000 0223    {
; 0000 0224    rx_buffer0[rx_wr_index0++]=data;
	LDS  R30,_rx_wr_index0
	SUBI R30,-LOW(1)
	STS  _rx_wr_index0,R30
	CALL SUBOPT_0x1D
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	ST   Z,R16
; 0000 0225 #if RX_BUFFER_SIZE0 == 256
; 0000 0226    // special case for receiver buffer size=256
; 0000 0227    if (++rx_counter0 == 0) rx_buffer_overflow0=1;
; 0000 0228 #else
; 0000 0229    if (rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
	LDS  R26,_rx_wr_index0
	CPI  R26,LOW(0x1E)
	BRNE _0xB1
	LDI  R30,LOW(0)
	STS  _rx_wr_index0,R30
; 0000 022A    if (++rx_counter0 == RX_BUFFER_SIZE0)
_0xB1:
	LDS  R26,_rx_counter0
	SUBI R26,-LOW(1)
	STS  _rx_counter0,R26
	CPI  R26,LOW(0x1E)
	BRNE _0xB2
; 0000 022B       {
; 0000 022C       rx_counter0=0;
	LDI  R30,LOW(0)
	STS  _rx_counter0,R30
; 0000 022D       rx_buffer_overflow0=1;
	SBI  0x1E,0
; 0000 022E       }
; 0000 022F #endif
; 0000 0230    }
_0xB2:
; 0000 0231 }
_0xB0:
	LD   R16,Y+
	LD   R17,Y+
	RJMP _0xC2
;//=============================================================================
;// USART Transmitter interrupt service routine
;interrupt [USART_TXC] void usart_tx_isr(void)
; 0000 0235 {
_usart_tx_isr:
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0236 if (tx_counter0)
	LDS  R30,_tx_counter0
	CPI  R30,0
	BREQ _0xB5
; 0000 0237    {
; 0000 0238    --tx_counter0;
	SUBI R30,LOW(1)
	STS  _tx_counter0,R30
; 0000 0239    UDR0=tx_buffer0[tx_rd_index0++];
	LDS  R30,_tx_rd_index0
	SUBI R30,-LOW(1)
	STS  _tx_rd_index0,R30
	CALL SUBOPT_0x1D
	SUBI R30,LOW(-_tx_buffer0)
	SBCI R31,HIGH(-_tx_buffer0)
	LD   R30,Z
	STS  198,R30
; 0000 023A #if TX_BUFFER_SIZE0 != 256
; 0000 023B    if (tx_rd_index0 == TX_BUFFER_SIZE0) tx_rd_index0=0;
	LDS  R26,_tx_rd_index0
	CPI  R26,LOW(0x1E)
	BRNE _0xB6
	LDI  R30,LOW(0)
	STS  _tx_rd_index0,R30
; 0000 023C #endif
; 0000 023D    }
_0xB6:
; 0000 023E }
_0xB5:
_0xC2:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
;//=============================================================================
;void SendDevs(){
; 0000 0240 void SendDevs(){
_SendDevs:
; 0000 0241     unsigned char i;
; 0000 0242     if (devices)
	ST   -Y,R17
;	i -> R17
	TST  R7
	BRNE PC+3
	JMP _0xB7
; 0000 0243     {
; 0000 0244         for (i=0;i<devices;i++)
	LDI  R17,LOW(0)
_0xB9:
	CP   R17,R7
	BRLO PC+3
	JMP _0xBA
; 0000 0245         {
; 0000 0246             delay_ms(10);
	LDI  R26,LOW(10)
	CALL SUBOPT_0xB
; 0000 0247             sprintf(lcd_buffer,"D[%d]:%02X%02X%02X%02X%02X%02X%02X%02X\r\n"
; 0000 0248             ,i
; 0000 0249             ,rom_codes[i][0]
; 0000 024A             ,rom_codes[i][1]
; 0000 024B             ,rom_codes[i][2]
; 0000 024C             ,rom_codes[i][3]
; 0000 024D             ,rom_codes[i][4]
; 0000 024E             ,rom_codes[i][5]
; 0000 024F             ,rom_codes[i][6]
; 0000 0250             ,rom_codes[i][7]);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,475
	CALL SUBOPT_0x9
	CALL SUBOPT_0x8
	LD   R30,Z
	CALL SUBOPT_0x13
	LDI  R26,LOW(9)
	MUL  R17,R26
	MOVW R30,R0
	__ADDW1MN _rom_codes,1
	LD   R30,Z
	CALL SUBOPT_0x13
	LDI  R26,LOW(9)
	MUL  R17,R26
	MOVW R30,R0
	__ADDW1MN _rom_codes,2
	LD   R30,Z
	CALL SUBOPT_0x13
	LDI  R26,LOW(9)
	MUL  R17,R26
	MOVW R30,R0
	__ADDW1MN _rom_codes,3
	LD   R30,Z
	CALL SUBOPT_0x13
	LDI  R26,LOW(9)
	MUL  R17,R26
	MOVW R30,R0
	__ADDW1MN _rom_codes,4
	LD   R30,Z
	CALL SUBOPT_0x13
	LDI  R26,LOW(9)
	MUL  R17,R26
	MOVW R30,R0
	__ADDW1MN _rom_codes,5
	LD   R30,Z
	CALL SUBOPT_0x13
	LDI  R26,LOW(9)
	MUL  R17,R26
	MOVW R30,R0
	__ADDW1MN _rom_codes,6
	LD   R30,Z
	CALL SUBOPT_0x13
	LDI  R26,LOW(9)
	MUL  R17,R26
	MOVW R30,R0
	__ADDW1MN _rom_codes,7
	LD   R30,Z
	CALL SUBOPT_0x13
	LDI  R24,36
	CALL _sprintf
	ADIW R28,40
; 0000 0251             SendData(lcd_buffer);
	LDI  R26,LOW(_lcd_buffer)
	LDI  R27,HIGH(_lcd_buffer)
	RCALL _SendData
; 0000 0252 
; 0000 0253         }
	SUBI R17,-1
	RJMP _0xB9
_0xBA:
; 0000 0254     }
; 0000 0255 }
_0xB7:
_0x20C000A:
	LD   R17,Y+
	RET
;//=============================================================================
;void getData(char *data)
; 0000 0258 {
_getData:
; 0000 0259    // unsigned char recidev = 0;
; 0000 025A     while(rx_counter0){
	ST   -Y,R27
	ST   -Y,R26
;	*data -> Y+0
_0xBB:
	LDS  R30,_rx_counter0
	CPI  R30,0
	BREQ _0xBD
; 0000 025B        *(data++) = getchar();
	LD   R30,Y
	LDD  R31,Y+1
	ADIW R30,1
	ST   Y,R30
	STD  Y+1,R31
	SBIW R30,1
	PUSH R31
	PUSH R30
	RCALL _getchar
	POP  R26
	POP  R27
	ST   X,R30
; 0000 025C       // recidev++;
; 0000 025D     }
	RJMP _0xBB
_0xBD:
; 0000 025E 
; 0000 025F }
	RJMP _0x20C0009
;
;//=============================================================================
;void SendData(char *data)
; 0000 0263 {
_SendData:
; 0000 0264     while(*data != 0)
	ST   -Y,R27
	ST   -Y,R26
;	*data -> Y+0
_0xBE:
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X
	CPI  R30,0
	BREQ _0xC0
; 0000 0265     {
; 0000 0266         putchar(*(data++));
	LD   R30,X+
	ST   Y,R26
	STD  Y+1,R27
	MOV  R26,R30
	RCALL _putchar
; 0000 0267         //delay_ms(1);
; 0000 0268     }
	RJMP _0xBE
_0xC0:
; 0000 0269 }
_0x20C0009:
	ADIW R28,2
	RET
;//=============================================================================
;void InitilizeMC()
; 0000 026C {
_InitilizeMC:
; 0000 026D     // Crystal Oscillator division factor: 1
; 0000 026E     #pragma optsize-
; 0000 026F     CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 0270     CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 0271     #ifdef _OPTIMIZE_SIZE_
; 0000 0272     #pragma optsize+
; 0000 0273     #endif
; 0000 0274 
; 0000 0275     PORTA=0x00;
	OUT  0x2,R30
; 0000 0276     DDRA=0x00;
	OUT  0x1,R30
; 0000 0277 
; 0000 0278     PORTB=0x00;
	OUT  0x5,R30
; 0000 0279     DDRB=0x07;
	LDI  R30,LOW(7)
	OUT  0x4,R30
; 0000 027A 
; 0000 027B     PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x8,R30
; 0000 027C     DDRC=0x00;
	OUT  0x7,R30
; 0000 027D 
; 0000 027E     PORTD=0x00;
	OUT  0xB,R30
; 0000 027F     DDRD=0x00;
	OUT  0xA,R30
; 0000 0280 
; 0000 0281     // Timer/Counter 0 initialization
; 0000 0282     // Clock source: System Clock
; 0000 0283     // Clock value: Timer 0 Stopped
; 0000 0284     // Mode: Normal top=0xFF
; 0000 0285     // OC0A output: Disconnected
; 0000 0286     // OC0B output: Disconnected
; 0000 0287     TCCR0A=0x00;
	OUT  0x24,R30
; 0000 0288     TCCR0B=0x00;
	OUT  0x25,R30
; 0000 0289     TCNT0=0x00;
	OUT  0x26,R30
; 0000 028A     OCR0A=0x00;
	OUT  0x27,R30
; 0000 028B     OCR0B=0x00;
	OUT  0x28,R30
; 0000 028C 
; 0000 028D     // Timer/Counter 1 initialization
; 0000 028E     // Clock source: System Clock
; 0000 028F     // Clock value: 8000,000 kHz
; 0000 0290     // Mode: Normal top=0xFFFF
; 0000 0291     // OC1A output: Discon.
; 0000 0292     // OC1B output: Discon.
; 0000 0293     // Noise Canceler: Off
; 0000 0294     // Input Capture on Falling Edge
; 0000 0295     // Timer1 Overflow Interrupt: On
; 0000 0296     // Input Capture Interrupt: Off
; 0000 0297     // Compare A Match Interrupt: Off
; 0000 0298     // Compare B Match Interrupt: Off
; 0000 0299     TCCR1A=0x00;
	STS  128,R30
; 0000 029A     TCCR1B=0x01;
	LDI  R30,LOW(1)
	STS  129,R30
; 0000 029B     TCNT1H=0x00;
	LDI  R30,LOW(0)
	STS  133,R30
; 0000 029C     TCNT1L=0x00;
	STS  132,R30
; 0000 029D     ICR1H=0x00;
	STS  135,R30
; 0000 029E     ICR1L=0x00;
	STS  134,R30
; 0000 029F     OCR1AH=0x00;
	STS  137,R30
; 0000 02A0     OCR1AL=0x00;
	STS  136,R30
; 0000 02A1     OCR1BH=0x00;
	STS  139,R30
; 0000 02A2     OCR1BL=0x00;
	STS  138,R30
; 0000 02A3 
; 0000 02A4     // Timer/Counter 2 initialization
; 0000 02A5     // Clock source: System Clock
; 0000 02A6     // Clock value: Timer2 Stopped
; 0000 02A7     // Mode: Normal top=0xFF
; 0000 02A8     // OC2A output: Disconnected
; 0000 02A9     // OC2B output: Disconnected
; 0000 02AA     ASSR=0x00;
	STS  182,R30
; 0000 02AB     TCCR2A=0x00;
	STS  176,R30
; 0000 02AC     TCCR2B=0x00;
	STS  177,R30
; 0000 02AD     TCNT2=0x00;
	STS  178,R30
; 0000 02AE     OCR2A=0x00;
	STS  179,R30
; 0000 02AF     OCR2B=0x00;
	STS  180,R30
; 0000 02B0 
; 0000 02B1     // External Interrupt(s) initialization
; 0000 02B2     // INT0: Off
; 0000 02B3     // INT1: Off
; 0000 02B4     // INT2: Off
; 0000 02B5     // Interrupt on any change on pins PCINT0-7: Off
; 0000 02B6     // Interrupt on any change on pins PCINT8-15: Off
; 0000 02B7     // Interrupt on any change on pins PCINT16-23: Off
; 0000 02B8     // Interrupt on any change on pins PCINT24-31: Off
; 0000 02B9     EICRA=0x00;
	STS  105,R30
; 0000 02BA     EIMSK=0x00;
	OUT  0x1D,R30
; 0000 02BB     PCICR=0x00;
	STS  104,R30
; 0000 02BC 
; 0000 02BD     // Timer/Counter 0 Interrupt(s) initialization
; 0000 02BE     TIMSK0=0x00;
	STS  110,R30
; 0000 02BF 
; 0000 02C0     // Timer/Counter 1 Interrupt(s) initialization
; 0000 02C1     TIMSK1=0x01;
	LDI  R30,LOW(1)
	STS  111,R30
; 0000 02C2 
; 0000 02C3     // Timer/Counter 2 Interrupt(s) initialization
; 0000 02C4     TIMSK2=0x00;
	LDI  R30,LOW(0)
	STS  112,R30
; 0000 02C5 
; 0000 02C6     // USART initialization
; 0000 02C7     // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 02C8     // USART Receiver: On
; 0000 02C9     // USART Transmitter: On
; 0000 02CA     // USART0 Mode: Asynchronous
; 0000 02CB     // USART Baud Rate: 9600
; 0000 02CC     UCSR0A=0x00;
	STS  192,R30
; 0000 02CD     UCSR0B=0xD8;
	LDI  R30,LOW(216)
	STS  193,R30
; 0000 02CE     UCSR0C=0x06;
	LDI  R30,LOW(6)
	STS  194,R30
; 0000 02CF     UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  197,R30
; 0000 02D0     UBRR0L=0x33;
	LDI  R30,LOW(51)
	STS  196,R30
; 0000 02D1 
; 0000 02D2     // Analog Comparator initialization
; 0000 02D3     // Analog Comparator: Off
; 0000 02D4     // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 02D5     ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 02D6     ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 02D7     DIDR1=0x00;
	STS  127,R30
; 0000 02D8 
; 0000 02D9     // ADC initialization
; 0000 02DA     // ADC disabled
; 0000 02DB     ADCSRA=0x00;
	STS  122,R30
; 0000 02DC 
; 0000 02DD     // SPI initialization
; 0000 02DE     // SPI disabled
; 0000 02DF     SPCR=0x00;
	OUT  0x2C,R30
; 0000 02E0 
; 0000 02E1     // TWI initialization
; 0000 02E2     // TWI disabled
; 0000 02E3     TWCR=0x00;
	STS  188,R30
; 0000 02E4 }
	RET
;//=============================================================================
;//=============================================================================
;//=============================================================================

	.CSEG
_memset:
	ST   -Y,R27
	ST   -Y,R26
    ldd  r27,y+1
    ld   r26,y
    adiw r26,0
    breq memset1
    ldd  r31,y+4
    ldd  r30,y+3
    ldd  r22,y+2
memset0:
    st   z+,r22
    sbiw r26,1
    brne memset0
memset1:
    ldd  r30,y+3
    ldd  r31,y+4
	JMP  _0x20C0004
_strcmp:
	ST   -Y,R27
	ST   -Y,R26
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
strcmp0:
    ld   r22,x+
    ld   r23,z+
    cp   r22,r23
    brne strcmp1
    tst  r22
    brne strcmp0
strcmp3:
    clr  r30
    ret
strcmp1:
    sub  r22,r23
    breq strcmp3
    ldi  r30,1
    brcc strcmp2
    subi r30,2
strcmp2:
    ret
_strcpyf:
	ST   -Y,R27
	ST   -Y,R26
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
    movw r24,r26
strcpyf0:
	lpm  r0,z+
    st   x+,r0
    tst  r0
    brne strcpyf0
    movw r30,r24
    ret
_strlen:
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
_strlenf:
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG
_put_buff_G101:
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2020010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2020012
	__CPWRN 16,17,2
	BRLO _0x2020013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2020012:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL SUBOPT_0x1E
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2020014
	CALL SUBOPT_0x1E
_0x2020014:
_0x2020013:
	RJMP _0x2020015
_0x2020010:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2020015:
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20C0004
__ftoe_G101:
	CALL SUBOPT_0x1F
	LDI  R30,LOW(128)
	STD  Y+2,R30
	LDI  R30,LOW(63)
	STD  Y+3,R30
	CALL __SAVELOCR4
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BRNE _0x2020019
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ST   -Y,R31
	ST   -Y,R30
	__POINTW2FN _0x2020000,0
	CALL _strcpyf
	RJMP _0x20C0008
_0x2020019:
	CPI  R30,LOW(0x7FFF)
	LDI  R26,HIGH(0x7FFF)
	CPC  R31,R26
	BRNE _0x2020018
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ST   -Y,R31
	ST   -Y,R30
	__POINTW2FN _0x2020000,1
	CALL _strcpyf
	RJMP _0x20C0008
_0x2020018:
	LDD  R26,Y+11
	CPI  R26,LOW(0x7)
	BRLO _0x202001B
	LDI  R30,LOW(6)
	STD  Y+11,R30
_0x202001B:
	LDD  R17,Y+11
_0x202001C:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x202001E
	CALL SUBOPT_0x20
	RJMP _0x202001C
_0x202001E:
	__GETD1S 12
	CALL __CPD10
	BRNE _0x202001F
	LDI  R19,LOW(0)
	CALL SUBOPT_0x20
	RJMP _0x2020020
_0x202001F:
	LDD  R19,Y+11
	CALL SUBOPT_0x21
	BREQ PC+2
	BRCC PC+3
	JMP  _0x2020021
	CALL SUBOPT_0x20
_0x2020022:
	CALL SUBOPT_0x21
	BRLO _0x2020024
	CALL SUBOPT_0x22
	CALL SUBOPT_0x23
	RJMP _0x2020022
_0x2020024:
	RJMP _0x2020025
_0x2020021:
_0x2020026:
	CALL SUBOPT_0x21
	BRSH _0x2020028
	CALL SUBOPT_0x22
	CALL SUBOPT_0x24
	CALL SUBOPT_0x25
	SUBI R19,LOW(1)
	RJMP _0x2020026
_0x2020028:
	CALL SUBOPT_0x20
_0x2020025:
	__GETD1S 12
	CALL SUBOPT_0x26
	CALL SUBOPT_0x25
	CALL SUBOPT_0x21
	BRLO _0x2020029
	CALL SUBOPT_0x22
	CALL SUBOPT_0x23
_0x2020029:
_0x2020020:
	LDI  R17,LOW(0)
_0x202002A:
	LDD  R30,Y+11
	CP   R30,R17
	BRLO _0x202002C
	__GETD2S 4
	CALL SUBOPT_0x27
	CALL SUBOPT_0x26
	MOVW R26,R30
	MOVW R24,R22
	CALL _floor
	__PUTD1S 4
	CALL SUBOPT_0x22
	CALL __DIVF21
	CALL __CFD1U
	MOV  R16,R30
	CALL SUBOPT_0x28
	CALL SUBOPT_0x29
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __CDF1
	__GETD2S 4
	CALL __MULF12
	CALL SUBOPT_0x22
	CALL SUBOPT_0x2A
	CALL SUBOPT_0x25
	MOV  R30,R17
	SUBI R17,-1
	CPI  R30,0
	BRNE _0x202002A
	CALL SUBOPT_0x28
	LDI  R30,LOW(46)
	ST   X,R30
	RJMP _0x202002A
_0x202002C:
	CALL SUBOPT_0x2B
	SBIW R30,1
	LDD  R26,Y+10
	STD  Z+0,R26
	CPI  R19,0
	BRGE _0x202002E
	NEG  R19
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(45)
	RJMP _0x202010E
_0x202002E:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(43)
_0x202010E:
	ST   X,R30
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x2B
	SBIW R30,1
	MOVW R22,R30
	MOV  R26,R19
	LDI  R30,LOW(10)
	CALL __DIVB21
	SUBI R30,-LOW(48)
	MOVW R26,R22
	ST   X,R30
	CALL SUBOPT_0x2B
	SBIW R30,1
	MOVW R22,R30
	MOV  R26,R19
	LDI  R30,LOW(10)
	CALL __MODB21
	SUBI R30,-LOW(48)
	MOVW R26,R22
	ST   X,R30
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(0)
	ST   X,R30
_0x20C0008:
	CALL __LOADLOCR4
	ADIW R28,16
	RET
__print_G101:
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,63
	SBIW R28,17
	CALL __SAVELOCR6
	LDI  R17,0
	__GETW1SX 88
	STD  Y+8,R30
	STD  Y+8+1,R31
	__GETW1SX 86
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2020030:
	MOVW R26,R28
	SUBI R26,LOW(-(92))
	SBCI R27,HIGH(-(92))
	CALL SUBOPT_0x1E
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+3
	JMP _0x2020032
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x2020036
	CPI  R18,37
	BRNE _0x2020037
	LDI  R17,LOW(1)
	RJMP _0x2020038
_0x2020037:
	CALL SUBOPT_0x2C
_0x2020038:
	RJMP _0x2020035
_0x2020036:
	CPI  R30,LOW(0x1)
	BRNE _0x2020039
	CPI  R18,37
	BRNE _0x202003A
	CALL SUBOPT_0x2C
	RJMP _0x202010F
_0x202003A:
	LDI  R17,LOW(2)
	LDI  R30,LOW(0)
	STD  Y+21,R30
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x202003B
	LDI  R16,LOW(1)
	RJMP _0x2020035
_0x202003B:
	CPI  R18,43
	BRNE _0x202003C
	LDI  R30,LOW(43)
	STD  Y+21,R30
	RJMP _0x2020035
_0x202003C:
	CPI  R18,32
	BRNE _0x202003D
	LDI  R30,LOW(32)
	STD  Y+21,R30
	RJMP _0x2020035
_0x202003D:
	RJMP _0x202003E
_0x2020039:
	CPI  R30,LOW(0x2)
	BRNE _0x202003F
_0x202003E:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2020040
	ORI  R16,LOW(128)
	RJMP _0x2020035
_0x2020040:
	RJMP _0x2020041
_0x202003F:
	CPI  R30,LOW(0x3)
	BRNE _0x2020042
_0x2020041:
	CPI  R18,48
	BRLO _0x2020044
	CPI  R18,58
	BRLO _0x2020045
_0x2020044:
	RJMP _0x2020043
_0x2020045:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x2020035
_0x2020043:
	LDI  R20,LOW(0)
	CPI  R18,46
	BRNE _0x2020046
	LDI  R17,LOW(4)
	RJMP _0x2020035
_0x2020046:
	RJMP _0x2020047
_0x2020042:
	CPI  R30,LOW(0x4)
	BRNE _0x2020049
	CPI  R18,48
	BRLO _0x202004B
	CPI  R18,58
	BRLO _0x202004C
_0x202004B:
	RJMP _0x202004A
_0x202004C:
	ORI  R16,LOW(32)
	LDI  R26,LOW(10)
	MUL  R20,R26
	MOV  R20,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x2020035
_0x202004A:
_0x2020047:
	CPI  R18,108
	BRNE _0x202004D
	ORI  R16,LOW(2)
	LDI  R17,LOW(5)
	RJMP _0x2020035
_0x202004D:
	RJMP _0x202004E
_0x2020049:
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0x2020035
_0x202004E:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x2020053
	CALL SUBOPT_0x2D
	CALL SUBOPT_0x2E
	CALL SUBOPT_0x2D
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x2F
	RJMP _0x2020054
_0x2020053:
	CPI  R30,LOW(0x45)
	BREQ _0x2020057
	CPI  R30,LOW(0x65)
	BRNE _0x2020058
_0x2020057:
	RJMP _0x2020059
_0x2020058:
	CPI  R30,LOW(0x66)
	BREQ PC+3
	JMP _0x202005A
_0x2020059:
	MOVW R30,R28
	ADIW R30,22
	STD  Y+14,R30
	STD  Y+14+1,R31
	CALL SUBOPT_0x30
	CALL __GETD1P
	CALL SUBOPT_0x31
	CALL SUBOPT_0x32
	LDD  R26,Y+13
	TST  R26
	BRMI _0x202005B
	LDD  R26,Y+21
	CPI  R26,LOW(0x2B)
	BREQ _0x202005D
	RJMP _0x202005E
_0x202005B:
	CALL SUBOPT_0x33
	CALL __ANEGF1
	CALL SUBOPT_0x31
	LDI  R30,LOW(45)
	STD  Y+21,R30
_0x202005D:
	SBRS R16,7
	RJMP _0x202005F
	LDD  R30,Y+21
	ST   -Y,R30
	CALL SUBOPT_0x2F
	RJMP _0x2020060
_0x202005F:
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	ADIW R30,1
	STD  Y+14,R30
	STD  Y+14+1,R31
	SBIW R30,1
	LDD  R26,Y+21
	STD  Z+0,R26
_0x2020060:
_0x202005E:
	SBRS R16,5
	LDI  R20,LOW(6)
	CPI  R18,102
	BRNE _0x2020062
	CALL SUBOPT_0x33
	CALL __PUTPARD1
	ST   -Y,R20
	LDD  R26,Y+19
	LDD  R27,Y+19+1
	CALL _ftoa
	RJMP _0x2020063
_0x2020062:
	CALL SUBOPT_0x33
	CALL __PUTPARD1
	ST   -Y,R20
	ST   -Y,R18
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	RCALL __ftoe_G101
_0x2020063:
	MOVW R30,R28
	ADIW R30,22
	CALL SUBOPT_0x34
	RJMP _0x2020064
_0x202005A:
	CPI  R30,LOW(0x73)
	BRNE _0x2020066
	CALL SUBOPT_0x32
	CALL SUBOPT_0x35
	CALL SUBOPT_0x34
	RJMP _0x2020067
_0x2020066:
	CPI  R30,LOW(0x70)
	BRNE _0x2020069
	CALL SUBOPT_0x32
	CALL SUBOPT_0x35
	STD  Y+14,R30
	STD  Y+14+1,R31
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2020067:
	ANDI R16,LOW(127)
	CPI  R20,0
	BREQ _0x202006B
	CP   R20,R17
	BRLO _0x202006C
_0x202006B:
	RJMP _0x202006A
_0x202006C:
	MOV  R17,R20
_0x202006A:
_0x2020064:
	LDI  R20,LOW(0)
	LDI  R30,LOW(0)
	STD  Y+20,R30
	LDI  R19,LOW(0)
	RJMP _0x202006D
_0x2020069:
	CPI  R30,LOW(0x64)
	BREQ _0x2020070
	CPI  R30,LOW(0x69)
	BRNE _0x2020071
_0x2020070:
	ORI  R16,LOW(4)
	RJMP _0x2020072
_0x2020071:
	CPI  R30,LOW(0x75)
	BRNE _0x2020073
_0x2020072:
	LDI  R30,LOW(10)
	STD  Y+20,R30
	SBRS R16,1
	RJMP _0x2020074
	__GETD1N 0x3B9ACA00
	CALL SUBOPT_0x36
	LDI  R17,LOW(10)
	RJMP _0x2020075
_0x2020074:
	__GETD1N 0x2710
	CALL SUBOPT_0x36
	LDI  R17,LOW(5)
	RJMP _0x2020075
_0x2020073:
	CPI  R30,LOW(0x58)
	BRNE _0x2020077
	ORI  R16,LOW(8)
	RJMP _0x2020078
_0x2020077:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0x20200B6
_0x2020078:
	LDI  R30,LOW(16)
	STD  Y+20,R30
	SBRS R16,1
	RJMP _0x202007A
	__GETD1N 0x10000000
	CALL SUBOPT_0x36
	LDI  R17,LOW(8)
	RJMP _0x2020075
_0x202007A:
	__GETD1N 0x1000
	CALL SUBOPT_0x36
	LDI  R17,LOW(4)
_0x2020075:
	CPI  R20,0
	BREQ _0x202007B
	ANDI R16,LOW(127)
	RJMP _0x202007C
_0x202007B:
	LDI  R20,LOW(1)
_0x202007C:
	SBRS R16,1
	RJMP _0x202007D
	CALL SUBOPT_0x32
	CALL SUBOPT_0x30
	ADIW R26,4
	CALL __GETD1P
	RJMP _0x2020110
_0x202007D:
	SBRS R16,2
	RJMP _0x202007F
	CALL SUBOPT_0x32
	CALL SUBOPT_0x35
	CALL __CWD1
	RJMP _0x2020110
_0x202007F:
	CALL SUBOPT_0x32
	CALL SUBOPT_0x35
	CLR  R22
	CLR  R23
_0x2020110:
	__PUTD1S 10
	SBRS R16,2
	RJMP _0x2020081
	LDD  R26,Y+13
	TST  R26
	BRPL _0x2020082
	CALL SUBOPT_0x33
	CALL __ANEGD1
	CALL SUBOPT_0x31
	LDI  R30,LOW(45)
	STD  Y+21,R30
_0x2020082:
	LDD  R30,Y+21
	CPI  R30,0
	BREQ _0x2020083
	SUBI R17,-LOW(1)
	SUBI R20,-LOW(1)
	RJMP _0x2020084
_0x2020083:
	ANDI R16,LOW(251)
_0x2020084:
_0x2020081:
	MOV  R19,R20
_0x202006D:
	SBRC R16,0
	RJMP _0x2020085
_0x2020086:
	CP   R17,R21
	BRSH _0x2020089
	CP   R19,R21
	BRLO _0x202008A
_0x2020089:
	RJMP _0x2020088
_0x202008A:
	SBRS R16,7
	RJMP _0x202008B
	SBRS R16,2
	RJMP _0x202008C
	ANDI R16,LOW(251)
	LDD  R18,Y+21
	SUBI R17,LOW(1)
	RJMP _0x202008D
_0x202008C:
	LDI  R18,LOW(48)
_0x202008D:
	RJMP _0x202008E
_0x202008B:
	LDI  R18,LOW(32)
_0x202008E:
	CALL SUBOPT_0x2C
	SUBI R21,LOW(1)
	RJMP _0x2020086
_0x2020088:
_0x2020085:
_0x202008F:
	CP   R17,R20
	BRSH _0x2020091
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x2020092
	CALL SUBOPT_0x37
	BREQ _0x2020093
	SUBI R21,LOW(1)
_0x2020093:
	SUBI R17,LOW(1)
	SUBI R20,LOW(1)
_0x2020092:
	LDI  R30,LOW(48)
	ST   -Y,R30
	CALL SUBOPT_0x2F
	CPI  R21,0
	BREQ _0x2020094
	SUBI R21,LOW(1)
_0x2020094:
	SUBI R20,LOW(1)
	RJMP _0x202008F
_0x2020091:
	MOV  R19,R17
	LDD  R30,Y+20
	CPI  R30,0
	BRNE _0x2020095
_0x2020096:
	CPI  R19,0
	BREQ _0x2020098
	SBRS R16,3
	RJMP _0x2020099
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	LPM  R18,Z+
	STD  Y+14,R30
	STD  Y+14+1,R31
	RJMP _0x202009A
_0x2020099:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	LD   R18,X+
	STD  Y+14,R26
	STD  Y+14+1,R27
_0x202009A:
	CALL SUBOPT_0x2C
	CPI  R21,0
	BREQ _0x202009B
	SUBI R21,LOW(1)
_0x202009B:
	SUBI R19,LOW(1)
	RJMP _0x2020096
_0x2020098:
	RJMP _0x202009C
_0x2020095:
_0x202009E:
	CALL SUBOPT_0x38
	CALL __DIVD21U
	MOV  R18,R30
	CPI  R18,10
	BRLO _0x20200A0
	SBRS R16,3
	RJMP _0x20200A1
	SUBI R18,-LOW(55)
	RJMP _0x20200A2
_0x20200A1:
	SUBI R18,-LOW(87)
_0x20200A2:
	RJMP _0x20200A3
_0x20200A0:
	SUBI R18,-LOW(48)
_0x20200A3:
	SBRC R16,4
	RJMP _0x20200A5
	CPI  R18,49
	BRSH _0x20200A7
	__GETD2S 16
	__CPD2N 0x1
	BRNE _0x20200A6
_0x20200A7:
	RJMP _0x20200A9
_0x20200A6:
	CP   R20,R19
	BRSH _0x2020111
	CP   R21,R19
	BRLO _0x20200AC
	SBRS R16,0
	RJMP _0x20200AD
_0x20200AC:
	RJMP _0x20200AB
_0x20200AD:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x20200AE
_0x2020111:
	LDI  R18,LOW(48)
_0x20200A9:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x20200AF
	CALL SUBOPT_0x37
	BREQ _0x20200B0
	SUBI R21,LOW(1)
_0x20200B0:
_0x20200AF:
_0x20200AE:
_0x20200A5:
	CALL SUBOPT_0x2C
	CPI  R21,0
	BREQ _0x20200B1
	SUBI R21,LOW(1)
_0x20200B1:
_0x20200AB:
	SUBI R19,LOW(1)
	CALL SUBOPT_0x38
	CALL __MODD21U
	CALL SUBOPT_0x31
	LDD  R30,Y+20
	__GETD2S 16
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __DIVD21U
	CALL SUBOPT_0x36
	__GETD1S 16
	CALL __CPD10
	BREQ _0x202009F
	RJMP _0x202009E
_0x202009F:
_0x202009C:
	SBRS R16,0
	RJMP _0x20200B2
_0x20200B3:
	CPI  R21,0
	BREQ _0x20200B5
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x2F
	RJMP _0x20200B3
_0x20200B5:
_0x20200B2:
_0x20200B6:
_0x2020054:
_0x202010F:
	LDI  R17,LOW(0)
_0x2020035:
	RJMP _0x2020030
_0x2020032:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,63
	ADIW R28,31
	RET
_sprintf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0x39
	SBIW R30,0
	BRNE _0x20200B7
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20C0007
_0x20200B7:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0x39
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G101)
	LDI  R31,HIGH(_put_buff_G101)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G101
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x20C0007:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET

	.CSEG
_ds18b20_select:
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	CALL _w1_init
	CPI  R30,0
	BRNE _0x2040003
	LDI  R30,LOW(0)
	RJMP _0x20C0005
_0x2040003:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	SBIW R30,0
	BREQ _0x2040004
	LDI  R26,LOW(85)
	CALL _w1_write
	LDI  R17,LOW(0)
_0x2040006:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R26,R30
	CALL _w1_write
	SUBI R17,-LOW(1)
	CPI  R17,8
	BRLO _0x2040006
	RJMP _0x2040008
_0x2040004:
	LDI  R26,LOW(204)
	CALL _w1_write
_0x2040008:
	LDI  R30,LOW(1)
	RJMP _0x20C0005
_ds18b20_read_spd:
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	RCALL _ds18b20_select
	CPI  R30,0
	BRNE _0x2040009
	LDI  R30,LOW(0)
	RJMP _0x20C0006
_0x2040009:
	LDI  R26,LOW(190)
	CALL _w1_write
	LDI  R17,LOW(0)
	__POINTWRM 18,19,___ds18b20_scratch_pad
_0x204000B:
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	CALL _w1_read
	POP  R26
	POP  R27
	ST   X,R30
	SUBI R17,-LOW(1)
	CPI  R17,9
	BRLO _0x204000B
	LDI  R30,LOW(___ds18b20_scratch_pad)
	LDI  R31,HIGH(___ds18b20_scratch_pad)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(9)
	CALL _w1_dow_crc8
	CALL __LNEGB1
_0x20C0006:
	CALL __LOADLOCR4
	ADIW R28,6
	RET
_ds18b20_temperature:
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	RCALL _ds18b20_read_spd
	CPI  R30,0
	BRNE _0x204000D
	CALL SUBOPT_0x3A
	RJMP _0x20C0005
_0x204000D:
	__GETB1MN ___ds18b20_scratch_pad,4
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	ANDI R30,LOW(0x3)
	MOV  R17,R30
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	RCALL _ds18b20_select
	CPI  R30,0
	BRNE _0x204000E
	CALL SUBOPT_0x3A
	RJMP _0x20C0005
_0x204000E:
	LDI  R26,LOW(68)
	CALL _w1_write
	MOV  R30,R17
	LDI  R26,LOW(_conv_delay_G102*2)
	LDI  R27,HIGH(_conv_delay_G102*2)
	CALL SUBOPT_0x3B
	CALL __GETW2PF
	CALL _delay_ms
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	RCALL _ds18b20_read_spd
	CPI  R30,0
	BRNE _0x204000F
	CALL SUBOPT_0x3A
	RJMP _0x20C0005
_0x204000F:
	CALL _w1_init
	MOV  R30,R17
	LDI  R26,LOW(_bit_mask_G102*2)
	LDI  R27,HIGH(_bit_mask_G102*2)
	CALL SUBOPT_0x3B
	CALL __GETW1PF
	LDS  R26,___ds18b20_scratch_pad
	LDS  R27,___ds18b20_scratch_pad+1
	AND  R30,R26
	AND  R31,R27
	CALL SUBOPT_0x3C
	__GETD2N 0x3D800000
	CALL __MULF12
_0x20C0005:
	LDD  R17,Y+0
	ADIW R28,3
	RET
_ds18b20_init:
	ST   -Y,R26
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	RCALL _ds18b20_select
	CPI  R30,0
	BRNE _0x2040010
	LDI  R30,LOW(0)
	RJMP _0x20C0004
_0x2040010:
	LD   R30,Y
	SWAP R30
	ANDI R30,0xF0
	LSL  R30
	ORI  R30,LOW(0x1F)
	ST   Y,R30
	LDI  R26,LOW(78)
	CALL _w1_write
	LDD  R26,Y+1
	CALL _w1_write
	LDD  R26,Y+2
	CALL _w1_write
	LD   R26,Y
	CALL _w1_write
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	RCALL _ds18b20_read_spd
	CPI  R30,0
	BRNE _0x2040011
	LDI  R30,LOW(0)
	RJMP _0x20C0004
_0x2040011:
	__GETB2MN ___ds18b20_scratch_pad,3
	LDD  R30,Y+2
	CP   R30,R26
	BRNE _0x2040013
	__GETB2MN ___ds18b20_scratch_pad,2
	LDD  R30,Y+1
	CP   R30,R26
	BRNE _0x2040013
	__GETB2MN ___ds18b20_scratch_pad,4
	LD   R30,Y
	CP   R30,R26
	BREQ _0x2040012
_0x2040013:
	LDI  R30,LOW(0)
	RJMP _0x20C0004
_0x2040012:
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	RCALL _ds18b20_select
	CPI  R30,0
	BRNE _0x2040015
	LDI  R30,LOW(0)
	RJMP _0x20C0004
_0x2040015:
	LDI  R26,LOW(72)
	CALL _w1_write
	LDI  R26,LOW(15)
	CALL SUBOPT_0xB
	CALL _w1_init
_0x20C0004:
	ADIW R28,5
	RET

	.CSEG

	.CSEG
_ftrunc:
	CALL __PUTPARD2
   ldd  r23,y+3
   ldd  r22,y+2
   ldd  r31,y+1
   ld   r30,y
   bst  r23,7
   lsl  r23
   sbrc r22,7
   sbr  r23,1
   mov  r25,r23
   subi r25,0x7e
   breq __ftrunc0
   brcs __ftrunc0
   cpi  r25,24
   brsh __ftrunc1
   clr  r26
   clr  r27
   clr  r24
__ftrunc2:
   sec
   ror  r24
   ror  r27
   ror  r26
   dec  r25
   brne __ftrunc2
   and  r30,r26
   and  r31,r27
   and  r22,r24
   rjmp __ftrunc1
__ftrunc0:
   clt
   clr  r23
   clr  r30
   clr  r31
   clr  r22
__ftrunc1:
   cbr  r22,0x80
   lsr  r23
   brcc __ftrunc3
   sbr  r22,0x80
__ftrunc3:
   bld  r23,7
   ld   r26,y+
   ld   r27,y+
   ld   r24,y+
   ld   r25,y+
   cp   r30,r26
   cpc  r31,r27
   cpc  r22,r24
   cpc  r23,r25
   bst  r25,7
   ret
_floor:
	CALL __PUTPARD2
	CALL __GETD2S0
	CALL _ftrunc
	CALL __PUTD1S0
    brne __floor1
__floor0:
	CALL __GETD1S0
	RJMP _0x20C0003
__floor1:
    brtc __floor0
	CALL __GETD1S0
	__GETD2N 0x3F800000
	CALL __SUBF12
_0x20C0003:
	ADIW R28,4
	RET

	.CSEG
_ftoa:
	RCALL SUBOPT_0x1F
	LDI  R30,LOW(0)
	STD  Y+2,R30
	LDI  R30,LOW(63)
	STD  Y+3,R30
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BRNE _0x20A000D
	RCALL SUBOPT_0x3D
	__POINTW2FN _0x20A0000,0
	CALL _strcpyf
	RJMP _0x20C0002
_0x20A000D:
	CPI  R30,LOW(0x7FFF)
	LDI  R26,HIGH(0x7FFF)
	CPC  R31,R26
	BRNE _0x20A000C
	RCALL SUBOPT_0x3D
	__POINTW2FN _0x20A0000,1
	CALL _strcpyf
	RJMP _0x20C0002
_0x20A000C:
	LDD  R26,Y+12
	TST  R26
	BRPL _0x20A000F
	__GETD1S 9
	CALL __ANEGF1
	RCALL SUBOPT_0x3E
	RCALL SUBOPT_0x3F
	LDI  R30,LOW(45)
	ST   X,R30
_0x20A000F:
	LDD  R26,Y+8
	CPI  R26,LOW(0x7)
	BRLO _0x20A0010
	LDI  R30,LOW(6)
	STD  Y+8,R30
_0x20A0010:
	LDD  R17,Y+8
_0x20A0011:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x20A0013
	RCALL SUBOPT_0x40
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0x41
	RJMP _0x20A0011
_0x20A0013:
	RCALL SUBOPT_0x42
	CALL __ADDF12
	RCALL SUBOPT_0x3E
	LDI  R17,LOW(0)
	__GETD1N 0x3F800000
	RCALL SUBOPT_0x41
_0x20A0014:
	RCALL SUBOPT_0x42
	CALL __CMPF12
	BRLO _0x20A0016
	RCALL SUBOPT_0x40
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x41
	SUBI R17,-LOW(1)
	CPI  R17,39
	BRLO _0x20A0017
	RCALL SUBOPT_0x3D
	__POINTW2FN _0x20A0000,5
	CALL _strcpyf
	RJMP _0x20C0002
_0x20A0017:
	RJMP _0x20A0014
_0x20A0016:
	CPI  R17,0
	BRNE _0x20A0018
	RCALL SUBOPT_0x3F
	LDI  R30,LOW(48)
	ST   X,R30
	RJMP _0x20A0019
_0x20A0018:
_0x20A001A:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x20A001C
	RCALL SUBOPT_0x40
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0x26
	MOVW R26,R30
	MOVW R24,R22
	CALL _floor
	RCALL SUBOPT_0x41
	RCALL SUBOPT_0x42
	CALL __DIVF21
	CALL __CFD1U
	MOV  R16,R30
	RCALL SUBOPT_0x3F
	RCALL SUBOPT_0x29
	LDI  R31,0
	RCALL SUBOPT_0x40
	RCALL SUBOPT_0x3C
	CALL __MULF12
	RCALL SUBOPT_0x43
	RCALL SUBOPT_0x2A
	RCALL SUBOPT_0x3E
	RJMP _0x20A001A
_0x20A001C:
_0x20A0019:
	LDD  R30,Y+8
	CPI  R30,0
	BREQ _0x20C0001
	RCALL SUBOPT_0x3F
	LDI  R30,LOW(46)
	ST   X,R30
_0x20A001E:
	LDD  R30,Y+8
	SUBI R30,LOW(1)
	STD  Y+8,R30
	SUBI R30,-LOW(1)
	BREQ _0x20A0020
	RCALL SUBOPT_0x43
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x3E
	__GETD1S 9
	CALL __CFD1U
	MOV  R16,R30
	RCALL SUBOPT_0x3F
	RCALL SUBOPT_0x29
	LDI  R31,0
	RCALL SUBOPT_0x43
	RCALL SUBOPT_0x3C
	RCALL SUBOPT_0x2A
	RCALL SUBOPT_0x3E
	RJMP _0x20A001E
_0x20A0020:
_0x20C0001:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
_0x20C0002:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,13
	RET

	.DSEG

	.CSEG

	.DSEG
___ds18b20_scratch_pad:
	.BYTE 0x9
_rom_codes:
	.BYTE 0x48
_temperature:
	.BYTE 0x20
_temperature_old:
	.BYTE 0x3C0
_lcd_buffer:
	.BYTE 0x1E
_input_buffer:
	.BYTE 0x1E
_temp_check:
	.BYTE 0x1
_rx_buffer0:
	.BYTE 0x1E
_tx_buffer0:
	.BYTE 0x1E

	.ESEG
_dev:
	.BYTE 0x6

	.DSEG
_rx_wr_index0:
	.BYTE 0x1
_rx_rd_index0:
	.BYTE 0x1
_rx_counter0:
	.BYTE 0x1
_tx_wr_index0:
	.BYTE 0x1
_tx_rd_index0:
	.BYTE 0x1
_tx_counter0:
	.BYTE 0x1
__seed_G105:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	LDI  R26,LOW(_dev)
	LDI  R27,HIGH(_dev)
	CALL __EEPROMRDB
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1:
	__POINTW2MN _dev,2
	CALL __EEPROMRDB
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	__POINTW2MN _dev,3
	CALL __EEPROMRDB
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	__POINTW2MN _dev,4
	CALL __EEPROMRDB
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x4:
	CALL _w1_init
	LDI  R30,LOW(240)
	ST   -Y,R30
	LDI  R26,LOW(_rom_codes)
	LDI  R27,HIGH(_rom_codes)
	CALL _w1_search
	MOV  R7,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 27 TIMES, CODE SIZE REDUCTION:49 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(_lcd_buffer)
	LDI  R31,HIGH(_lcd_buffer)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x6:
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R7
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	LDI  R26,LOW(_lcd_buffer)
	LDI  R27,HIGH(_lcd_buffer)
	JMP  _SendData

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:29 WORDS
SUBOPT_0x7:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _sprintf
	ADIW R28,4
	LDI  R26,LOW(_lcd_buffer)
	LDI  R27,HIGH(_lcd_buffer)
	JMP  _SendData

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x8:
	LDI  R26,LOW(9)
	MUL  R17,R26
	MOVW R30,R0
	SUBI R30,LOW(-_rom_codes)
	SBCI R31,HIGH(-_rom_codes)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x9:
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R17
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:63 WORDS
SUBOPT_0xA:
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	LDI  R26,LOW(_lcd_buffer)
	LDI  R27,HIGH(_lcd_buffer)
	JMP  _SendData

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0xB:
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC:
	__POINTW2MN _dev,1
	CALL __EEPROMRDB
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xD:
	LDI  R31,0
	ADD  R30,R0
	ADC  R31,R1
	MOV  R26,R3
	LDI  R27,0
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 32 TIMES, CODE SIZE REDUCTION:59 WORDS
SUBOPT_0xE:
	LDI  R30,LOW(_input_buffer)
	LDI  R31,HIGH(_input_buffer)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:45 WORDS
SUBOPT_0xF:
	MOV  R30,R17
	LDI  R26,LOW(_temperature)
	LDI  R27,HIGH(_temperature)
	LDI  R31,0
	CALL __LSLW2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x10:
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	MOVW R26,R30
	MOVW R24,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	__GETD1N 0x42500000
	CALL __CMPF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	__GETD1N 0x42840000
	CALL __CMPF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 26 TIMES, CODE SIZE REDUCTION:72 WORDS
SUBOPT_0x13:
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x14:
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x15:
	CALL __PUTPARD1
	LDI  R24,8
	CALL _sprintf
	ADIW R28,12
	LDI  R26,LOW(_lcd_buffer)
	LDI  R27,HIGH(_lcd_buffer)
	JMP  _SendData

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x16:
	LDI  R24,12
	CALL _sprintf
	ADIW R28,16
	LDI  R26,LOW(_lcd_buffer)
	LDI  R27,HIGH(_lcd_buffer)
	JMP  _SendData

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	__POINTW1FN _0x0,336
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xC

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x18:
	__POINTW1FN _0x0,355
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x19:
	__POINTW1FN _0x0,374
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1A:
	__POINTW1FN _0x0,393
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1B:
	CALL __EEPROMWRB
	RJMP SUBOPT_0x5

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1C:
	__GETB1MN _input_buffer,6
	RJMP SUBOPT_0x1B

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1D:
	SUBI R30,LOW(1)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1E:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1F:
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	LDI  R30,LOW(0)
	ST   Y,R30
	STD  Y+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0x20:
	__GETD2S 4
	__GETD1N 0x41200000
	CALL __MULF12
	__PUTD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x21:
	__GETD1S 4
	__GETD2S 12
	CALL __CMPF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x22:
	__GETD2S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x23:
	__GETD1N 0x3DCCCCCD
	CALL __MULF12
	__PUTD1S 12
	SUBI R19,-LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x24:
	__GETD1N 0x41200000
	CALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x25:
	__PUTD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x26:
	__GETD2N 0x3F000000
	CALL __ADDF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x27:
	__GETD1N 0x3DCCCCCD
	CALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x28:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,1
	STD  Y+8,R26
	STD  Y+8+1,R27
	SBIW R26,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x29:
	MOV  R30,R16
	SUBI R30,-LOW(48)
	ST   X,R30
	MOV  R30,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2A:
	CALL __SWAPD12
	CALL __SUBF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x2B:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,1
	STD  Y+8,R30
	STD  Y+8+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x2C:
	ST   -Y,R18
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x2D:
	__GETW1SX 90
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x2E:
	SBIW R30,4
	__PUTW1SX 90
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x2F:
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x30:
	__GETW2SX 90
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x31:
	__PUTD1S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x32:
	RCALL SUBOPT_0x2D
	RJMP SUBOPT_0x2E

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x33:
	__GETD1S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x34:
	STD  Y+14,R30
	STD  Y+14+1,R31
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	CALL _strlen
	MOV  R17,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x35:
	RCALL SUBOPT_0x30
	ADIW R26,4
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x36:
	__PUTD1S 16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x37:
	ANDI R16,LOW(251)
	LDD  R30,Y+21
	ST   -Y,R30
	__GETW2SX 87
	__GETW1SX 89
	ICALL
	CPI  R21,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x38:
	__GETD1S 16
	__GETD2S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x39:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3A:
	__GETD1N 0xC61C3C00
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x3B:
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3C:
	CALL __CWD1
	CALL __CDF1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3D:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3E:
	__PUTD1S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x3F:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,1
	STD  Y+6,R26
	STD  Y+6+1,R27
	SBIW R26,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x40:
	__GETD2S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x41:
	__PUTD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x42:
	__GETD1S 2
	__GETD2S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x43:
	__GETD2S 9
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

	.equ __w1_port=0x08
	.equ __w1_bit=0x00

_w1_init:
	clr  r30
	cbi  __w1_port,__w1_bit
	sbi  __w1_port-1,__w1_bit
	__DELAY_USW 0x3C0
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x25
	sbis __w1_port-2,__w1_bit
	ret
	__DELAY_USB 0xCB
	sbis __w1_port-2,__w1_bit
	ldi  r30,1
	__DELAY_USW 0x30C
	ret

__w1_read_bit:
	sbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x5
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x1D
	clc
	sbic __w1_port-2,__w1_bit
	sec
	ror  r30
	__DELAY_USB 0xD5
	ret

__w1_write_bit:
	clt
	sbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x5
	sbrc r23,0
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x23
	sbic __w1_port-2,__w1_bit
	rjmp __w1_write_bit0
	sbrs r23,0
	rjmp __w1_write_bit1
	ret
__w1_write_bit0:
	sbrs r23,0
	ret
__w1_write_bit1:
	__DELAY_USB 0xC8
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0xD
	set
	ret

_w1_read:
	ldi  r22,8
	__w1_read0:
	rcall __w1_read_bit
	dec  r22
	brne __w1_read0
	ret

_w1_write:
	mov  r23,r26
	ldi  r22,8
	clr  r30
__w1_write0:
	rcall __w1_write_bit
	brtc __w1_write1
	ror  r23
	dec  r22
	brne __w1_write0
	inc  r30
__w1_write1:
	ret

_w1_search:
	push r20
	push r21
	clr  r1
	clr  r20
__w1_search0:
	mov  r0,r1
	clr  r1
	rcall _w1_init
	tst  r30
	breq __w1_search7
	push r26
	ld   r26,y
	rcall _w1_write
	pop  r26
	ldi  r21,1
__w1_search1:
	cp   r21,r0
	brsh __w1_search6
	rcall __w1_read_bit
	sbrc r30,7
	rjmp __w1_search2
	rcall __w1_read_bit
	sbrc r30,7
	rjmp __w1_search3
	rcall __sel_bit
	and  r24,r25
	brne __w1_search3
	mov  r1,r21
	rjmp __w1_search3
__w1_search2:
	rcall __w1_read_bit
__w1_search3:
	rcall __sel_bit
	and  r24,r25
	ldi  r23,0
	breq __w1_search5
__w1_search4:
	ldi  r23,1
__w1_search5:
	rcall __w1_write_bit
	rjmp __w1_search13
__w1_search6:
	rcall __w1_read_bit
	sbrs r30,7
	rjmp __w1_search9
	rcall __w1_read_bit
	sbrs r30,7
	rjmp __w1_search8
__w1_search7:
	mov  r30,r20
	pop  r21
	pop  r20
	adiw r28,1
	ret
__w1_search8:
	set
	rcall __set_bit
	rjmp __w1_search4
__w1_search9:
	rcall __w1_read_bit
	sbrs r30,7
	rjmp __w1_search10
	rjmp __w1_search11
__w1_search10:
	cp   r21,r0
	breq __w1_search12
	mov  r1,r21
__w1_search11:
	clt
	rcall __set_bit
	clr  r23
	rcall __w1_write_bit
	rjmp __w1_search13
__w1_search12:
	set
	rcall __set_bit
	ldi  r23,1
	rcall __w1_write_bit
__w1_search13:
	inc  r21
	cpi  r21,65
	brlt __w1_search1
	rcall __w1_read_bit
	rol  r30
	rol  r30
	andi r30,1
	adiw r26,8
	st   x,r30
	sbiw r26,8
	inc  r20
	tst  r1
	breq __w1_search7
	ldi  r21,9
__w1_search14:
	ld   r30,x
	adiw r26,9
	st   x,r30
	sbiw r26,8
	dec  r21
	brne __w1_search14
	rjmp __w1_search0

__sel_bit:
	mov  r30,r21
	dec  r30
	mov  r22,r30
	lsr  r30
	lsr  r30
	lsr  r30
	clr  r31
	add  r30,r26
	adc  r31,r27
	ld   r24,z
	ldi  r25,1
	andi r22,7
__sel_bit0:
	breq __sel_bit1
	lsl  r25
	dec  r22
	rjmp __sel_bit0
__sel_bit1:
	ret

__set_bit:
	rcall __sel_bit
	brts __set_bit2
	com  r25
	and  r24,r25
	rjmp __set_bit3
__set_bit2:
	or   r24,r25
__set_bit3:
	st   z,r24
	ret

_w1_dow_crc8:
	clr  r30
	tst  r26
	breq __w1_dow_crc83
	mov  r24,r26
	ldi  r22,0x18
	ld   r26,y
	ldd  r27,y+1
__w1_dow_crc80:
	ldi  r25,8
	ld   r31,x+
__w1_dow_crc81:
	mov  r23,r31
	eor  r23,r30
	ror  r23
	brcc __w1_dow_crc82
	eor  r30,r22
__w1_dow_crc82:
	ror  r30
	lsr  r31
	dec  r25
	brne __w1_dow_crc81
	dec  r24
	brne __w1_dow_crc80
__w1_dow_crc83:
	adiw r28,2
	ret

__ANEGF1:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __ANEGF10
	SUBI R23,0x80
__ANEGF10:
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

	RJMP __ADDF120

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__CBD1:
	MOV  R31,R30
	ADD  R31,R31
	SBC  R31,R31
	MOV  R22,R31
	MOV  R23,R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__LNEGB1:
	TST  R30
	LDI  R30,1
	BREQ __LNEGB1F
	CLR  R30
__LNEGB1F:
	RET

__DIVB21U:
	CLR  R0
	LDI  R25,8
__DIVB21U1:
	LSL  R26
	ROL  R0
	SUB  R0,R30
	BRCC __DIVB21U2
	ADD  R0,R30
	RJMP __DIVB21U3
__DIVB21U2:
	SBR  R26,1
__DIVB21U3:
	DEC  R25
	BRNE __DIVB21U1
	MOV  R30,R26
	MOV  R26,R0
	RET

__DIVB21:
	RCALL __CHKSIGNB
	RCALL __DIVB21U
	BRTC __DIVB211
	NEG  R30
__DIVB211:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__MODB21:
	CLT
	SBRS R26,7
	RJMP __MODB211
	NEG  R26
	SET
__MODB211:
	SBRC R30,7
	NEG  R30
	RCALL __DIVB21U
	MOV  R30,R26
	BRTC __MODB212
	NEG  R30
__MODB212:
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__MODD21U:
	RCALL __DIVD21U
	MOVW R30,R26
	MOVW R22,R24
	RET

__CHKSIGNB:
	CLT
	SBRS R30,7
	RJMP __CHKSB1
	NEG  R30
	SET
__CHKSB1:
	SBRS R26,7
	RJMP __CHKSB2
	NEG  R26
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSB2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETD1P:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X
	SBIW R26,3
	RET

__PUTDP1:
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__GETW2PF:
	LPM  R26,Z+
	LPM  R27,Z
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
