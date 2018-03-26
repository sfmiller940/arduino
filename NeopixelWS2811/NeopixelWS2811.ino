#include "FastLED.h"
#define NUM_LEDS 50
CRGBArray<NUM_LEDS> leds;

void setup() { FastLED.addLeds<NEOPIXEL, 7>(leds, NUM_LEDS); }

void loop() { 
  static uint8_t hue=0;
  leds(0,NUM_LEDS/2 - 1).fill_rainbow(hue++);
  leds(NUM_LEDS/2, NUM_LEDS-1) = leds(NUM_LEDS/2-1,0);
  FastLED.delay(30);
}
