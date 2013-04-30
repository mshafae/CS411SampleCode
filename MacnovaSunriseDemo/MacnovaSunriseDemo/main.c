//
//  main.c
//  MacnovaSunriseDemo
//
//  Created by Michael Shafae on 4/30/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//
// Inspired by <http://libnova.sourceforge.net/sun_8c-example.html>
// Definition of each kind of sunrise/sunset from
// http://aa.usno.navy.mil/faq/docs/RST_defs.php

#include <libnova/solar.h>
#include <libnova/julian_day.h>
#include <libnova/rise_set.h>
#include <libnova/transform.h>
#include <libnova/utility.h>
#include <libnova/refraction.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Fullerton, CA
#define LAT (33.879)
#define LON (-117.90)

/* station elevation in feet above sea level */
#define ELEV   (164.0)

static struct ln_lnlat_posn observer;
static double JD;
static struct ln_helio_posn pos;
static struct ln_equ_posn equ;

void calc_common() {
  observer.lat = LAT;
  observer.lng = LON;
  JD = ln_get_julian_from_sys();
  ln_get_solar_geom_coords(JD, &pos);
  ln_get_solar_equ_coords(JD, &equ);
}

float convFtoC(float tempF) {
  
  return (float) (5.0 * (tempF - 32) / 9.0);
}

float convinHgtomb(float pressureinHg) {
  
  return (float) (33.8639 * pressureinHg);
}

float calc_daylight_hours(struct ln_zonedate *r, struct ln_zonedate *s) {
  
  struct tm br, bs;
  time_t cr, cs;
  float h = 0;
  
  br.tm_year = bs.tm_year = s->years - 1900;
  br.tm_mon = bs.tm_mon = s->months - 1;
  br.tm_mday = bs.tm_mday = s->days;
  br.tm_hour = r->hours;
  br.tm_min = r->minutes;
  br.tm_sec = round(r->seconds);
  bs.tm_hour = s->hours;
  bs.tm_min = s->minutes;
  bs.tm_sec = round(s->seconds);
  cr = mktime(&br);
  cs = mktime(&bs);
  if (cr != -1 && cs != -1)
    h = (float) (cs - cr) / 3600.0;
  
  return (h);
}


void calc_rst(uint16_t *dest) {
  struct ln_rst_time rst;
  struct ln_zonedate rise, set, transit;
  
  printf("LN_SOLAR_STANDART_HORIZON: %g\n", LN_SOLAR_STANDART_HORIZON );
  printf("\n");
  if( ln_get_solar_rst_horizon(JD, &observer, LN_SOLAR_STANDART_HORIZON, &rst) == 1 ){
    printf ("Sun is circumpolar\n");
  }else{
    ln_get_local_date(rst.rise, &rise);
    ln_get_local_date(rst.transit, &transit);
    ln_get_local_date(rst.set, &set);
    /*dest[modptr++] = transit.hours;
     dest[modptr++] = transit.minutes;
     dest[modptr++] = (int) round(transit.seconds);
     dest[modptr++] = rise.hours;
     dest[modptr++] = rise.minutes;
     dest[modptr++] = (int) round(rise.seconds);
     dest[modptr++] = set.hours;
     dest[modptr++] = set.minutes;
     dest[modptr++] = (int) round(set.seconds);
     modptr += calc_daylight_hours(&rise, &set), &dest[modptr];*/
    printf( "rise: %.2d:%.2d:%.2d\n", rise.hours, rise.minutes, (int) round(rise.seconds) );
    printf( "set: %.2d:%.2d:%.2d\n", set.hours, set.minutes, (int) round(set.seconds) );
    printf( "daylight hours: %g\n", calc_daylight_hours(&rise, &set) );
  }
  printf("LN_SOLAR_CIVIL_HORIZON: %g\n", LN_SOLAR_CIVIL_HORIZON );
  printf("Civil twilight is defined to begin in the morning, and to end in the evening when the center of the Sun is geometrically 6 degrees below the horizon. This is the limit at which twilight illumination is sufficient, under good weather conditions, for terrestrial objects to be clearly distinguished; at the beginning of morning civil twilight, or end of evening civil twilight, the horizon is clearly defined and the brightest stars are visible under good atmospheric conditions in the absence of moonlight or other illumination. In the morning before the beginning of civil twilight and in the evening after the end of civil twilight, artificial illumination is normally required to carry on ordinary outdoor activities.\n");
  if( ln_get_solar_rst_horizon(JD, &observer, LN_SOLAR_CIVIL_HORIZON, &rst) == 1 ){
    printf ("Sun is circumpolar\n");
  }else{
    ln_get_local_date(rst.rise, &rise);
    ln_get_local_date(rst.transit, &transit);
    ln_get_local_date(rst.set, &set);
    printf( "rise: %.2d:%.2d:%.2d\n", rise.hours, rise.minutes, (int) round(rise.seconds) );
    printf( "set: %.2d:%.2d:%.2d\n", set.hours, set.minutes, (int) round(set.seconds) );
    printf( "daylight hours: %g\n", calc_daylight_hours(&rise, &set) );
  }
  printf("LN_SOLAR_NAUTIC_HORIZON: %g\n", LN_SOLAR_NAUTIC_HORIZON );
  printf("Nautical twilight is defined to begin in the morning, and to end in the evening, when the center of the sun is geometrically 12 degrees below the horizon. At the beginning or end of nautical twilight, under good atmospheric conditions and in the absence of other illumination, general outlines of ground objects may be distinguishable, but detailed outdoor operations are not possible. During nautical twilight the illumination level is such that the horizon is still visible even on a Moonless night allowing mariners to take reliable star sights for navigational purposes, hence the name.\n");
  if( ln_get_solar_rst_horizon(JD, &observer, LN_SOLAR_NAUTIC_HORIZON, &rst) == 1 ){
    printf ("Sun is circumpolar\n");
  }else{
    ln_get_local_date(rst.rise, &rise);
    ln_get_local_date(rst.transit, &transit);
    ln_get_local_date(rst.set, &set);
    printf( "rise: %.2d:%.2d:%.2d\n", rise.hours, rise.minutes, (int) round(rise.seconds) );
    printf( "set: %.2d:%.2d:%.2d\n", set.hours, set.minutes, (int) round(set.seconds) );
    printf( "daylight hours: %g\n", calc_daylight_hours(&rise, &set) );
  }
  
  printf("LN_SOLAR_ASTRONOMICAL_HORIZON: %g\n", LN_SOLAR_ASTRONOMICAL_HORIZON );
  printf("Astronomical twilight is defined to begin in the morning, and to end in the evening when the center of the Sun is geometrically 18 degrees below the horizon. Before the beginning of astronomical twilight in the morning and after the end of astronomical twilight in the evening, scattered light from the Sun is less than that from starlight and other natural sources. For a considerable interval after the beginning of morning twilight and before the end of evening twilight, sky illumination is so faint that it is practically imperceptible.\n");
  if( ln_get_solar_rst_horizon(JD, &observer, LN_SOLAR_ASTRONOMICAL_HORIZON, &rst) == 1 ){
    printf ("Sun is circumpolar\n");
  }else{
    ln_get_local_date(rst.rise, &rise);
    ln_get_local_date(rst.transit, &transit);
    ln_get_local_date(rst.set, &set);
    printf( "rise: %.2d:%.2d:%.2d\n", rise.hours, rise.minutes, (int) round(rise.seconds) );
    printf( "set: %.2d:%.2d:%.2d\n", set.hours, set.minutes, (int) round(set.seconds) );
    printf( "daylight hours: %g\n", calc_daylight_hours(&rise, &set) );
  }
  
  //...
	
}

int main( void ){
  uint16_t d[10];
  calc_common( );
  calc_rst(d);
  return(0);
}
