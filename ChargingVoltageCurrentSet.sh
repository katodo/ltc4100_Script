#!/bin/bash

#Device address map
ADD_LTC4100_READ=0x09
ADD_SMBUS_SYSTEM_HOST=0x10
ADD_SMART_BATTERY_CHARGER=0x12
ADD_SMART_BATTERY_SELECTOR=0x14
ADD_SMART_BATTERY=0x16

#ReadOnly LTC4100 Register
LTC4100_CHARGER_SPEC_INFO=0x11
LTC4100_CHARGER_STATUS=0x13

#WriteOnly LTC4100 Register
LTC4100_CHARGER_MODE=0x12
LTC4100_CHARGING_CURRENT=0x14
LTC4100_CHARGING_VOLTAGE=0x15
LTC4100_ALARM_WARNING=0x16

#Read/Write LTC4100 Register
LTC4100_LTCO=0x3C


#  //  SMBALERT will be de-asserted upon a successful read of ChargerStatus() pg.10 http://cds.linear.com/docs/en/datasheet/4100fc.pdf
#  Serial.print("LTC4100_CHARGER_STATUS   : ");Serial.print("\t");Serial.println(SMBReadWordCommand(ADD_SMART_BATTERY_CHARGER, LTC4100_CHARGER_STATUS));
#	SMBWriteWordCommand(ADD_SMART_BATTERY_CHARGER, LTC4100_CHARGER_MODE, 8);


while true; do
	# Voltage and Current mus be re-sended each 140-210 Sec to avoid timeout	
	#	http://cds.linear.com/docs/en/datasheet/4100fc.pdf
	# Pg.5 	: Time Between Receiving Valid ChargingCurrent() and ChargingVoltage() Commands
	# Pg.10 : The wake-up current is discontinued after tTIMEOUT if the SafetySignal is decoded 
	#	  as RES_UR or RES_C0LD, and the battery or host doesn't transmit charging commands
	
	echo $(date) ' : Set charging voltage to ' $1 'mV and current to ' $2 'mA'
	i2cset -y 1 $ADD_LTC4100_READ $LTC4100_CHARGING_VOLTAGE $1 w
#	echo 'Set charging current to : ' $2 ' mA'
	i2cset -y 1 $ADD_LTC4100_READ $LTC4100_CHARGING_CURRENT $2 w
	sleep 20
done
