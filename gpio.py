#!/usr/bin/python3
import RPi.GPIO as GPIO
import time # die GPIOS koennen über die PINNummer oder die GPIONummer
# angesprochen werden
GPIO.setmode(GPIO.BCM) # hier GPIO-Nummer
GPIO.setup(23, GPIO.OUT) interval_in_s = 120.0
while(True):
    print("on")
    GPIO.output(23, GPIO.HIGH)
    time.sleep(interval_in_s) # sleep interval in Sekunden
    print("off")
    GPIO.output(23, GPIO.LOW)
    time.sleep(interval_in_s)
