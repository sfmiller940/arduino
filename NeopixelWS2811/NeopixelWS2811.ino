#include "FastLED.h"
#define NUM_LEDS 50
CRGBArray<NUM_LEDS> leds;

void setup() { FastLED.addLeds<NEOPIXEL, 7>(leds, NUM_LEDS); }

void loop(){
  static uint8_t hue=0;
  for(int dot = 0; dot < NUM_LEDS; dot++) { 
    leds[dot] = CHSV( (hue * ( 1 - ( 2 * ( dot % 2 ) ) ) ) + (255 * dot / NUM_LEDS), 255, 255);
  }
  FastLED.show();
  delay(20);
  hue++;
}

