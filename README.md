Arduino Counters by Stephen F. Miller
=====================

binarycounter.c 
---------------

This is a basic binary counter designed for an 8x8 LED matrix. The constant
persec can be adjusted to change the counting speed.


rainbowcounter.c
----------------

This is a binary counter with a scrolling RGB gradient background. 
This is designed to run on an 8x8 RGB LED matrix. There are only
enough pins to use 3 rows of the LED matrix.

Future Plans
---------------

I hope to incorporate a real time clock for accurate timing, and shift registers so I can use more than 3 rows of RGB LEDS.
The ultimate goal is to construct a physical version of our modular clock:

http://poibella.org

http://github.com/sfmiller940/viz

