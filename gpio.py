#!/usr/bin/python3

import RPi.GPIO as GPIO
import time
import smbus2
import bme280

# Requires: 'adafruit-circuitpython-bme280' from pip
TEMPERATURE = 23
port = 1
address = 0x77
bus = smbus2.SMBus(port)
calibration_params = bme280.load_calibration_params(bus, address)
fanPin = 23

GPIO.setmode(GPIO.BCM)

GPIO.setup(fanPin, GPIO.OUT)
check_interval = 1.0 # Seconds

def on():
    GPIO.output(fanPin, 1)

def on():
    GPIO.output(fanPin, 0)

while True:
    sensorTemperature = data = bme280.sample(bus, address, calibration_params).temperature

    if sensorTemperature > TEMPERATURE:
        on()
    else:
        off()

time.sleep(check_interval)
