



import 'package:flutter/cupertino.dart';
import 'package:weather/weather.dart';

class Weather{
  final  temperatureC;
  final  temperatureF;
  final String condition;
  final humidity;
  final wind_kph;
  final precip_mm;
  final feelslike_c;
  final uv;
  final String wind_dir;
  final String name;
  final String region;
  final maxtemp_c;
  final mintemp_c;
  final hour_temp_c;
  final hour_time_epoch;
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moon_phase;
  final String condition_icon;
  final String hour_time;
  final  hour_icon;
  final String day_date;
  final maks_derece;
  final min_derece;
  final ort_durumu;
  final ort_durumu_icon;
  final date_epoch;

  Weather({

    this.temperatureC = 0,
    this.temperatureF = 0,
    this.condition = "",
    this.humidity = 0,
    this.wind_kph = 0,
    this.precip_mm = 0,
    this.feelslike_c =0,
    this.uv= 0,
    this.wind_dir="",
    this.name = "",
    this.region = "",
    this.maxtemp_c ="",
    this.mintemp_c ="",
    this.hour_temp_c=0,
    this.hour_time_epoch=0,
    this.sunrise="",
    this.sunset="",
    this.moonrise="",
    this.moonset="",
    this.moon_phase="",
    this.condition_icon="",
    this.hour_time="",
    this.hour_icon="",
    this.day_date="",
    this.maks_derece=0,
    this.min_derece=0,
    this.ort_durumu="",
    this.ort_durumu_icon="",
    this.date_epoch=0,


  } );
  factory Weather.fromJson(Map<String, dynamic> json){

    return Weather(
      temperatureC: json["current"]["temp_c"].toInt(),
      temperatureF: json["current"]["temp_f"].toInt(),
      condition: json["current"]["condition"]["text"],
      humidity: json["current"]["humidity"].toInt(),
      wind_kph: json["current"]["wind_kph"].toInt(),
      precip_mm: json["current"]["precip_mm"],
      feelslike_c: json["current"]["feelslike_c"].toInt(),
      uv: json["current"]["uv"].toInt(),
      wind_dir: json["current"]["wind_dir"],
      condition_icon: json["current"]["condition"]["icon"],

      name: json["location"]["name"],
      region: json["location"]["region"],
      maxtemp_c: json["forecast"]["forecastday"][0]["day"]["maxtemp_c"].toInt(),
      mintemp_c: json["forecast"]["forecastday"][0]["day"]["mintemp_c"].toInt(),

      hour_time_epoch: json["forecast"]["forecastday"][0]["hour"][0]["time_epoch"],
      sunrise: json["forecast"]["forecastday"][0]["astro"]["sunrise"],
      sunset: json["forecast"]["forecastday"][0]["astro"]["sunset"],
      moonrise: json["forecast"]["forecastday"][0]["astro"]["moonrise"],
      moonset: json["forecast"]["forecastday"][0]["astro"]["moonset"],
      moon_phase: json["forecast"]["forecastday"][0]["astro"]["moon_phase"],



      hour_temp_c: json["forecast"]["forecastday"][0]["hour"][0]["temp_c"].toInt(),
      hour_time: json["forecast"]["forecastday"][0]["hour"][0]["time"],
      hour_icon: json["forecast"]["forecastday"][0]["hour"][0]["condition"]["icon"],

      //---------Haftalık------

      maks_derece: json["forecast"]["forecastday"][0]["day"]["maxtemp_c"].round(),
      min_derece: json["forecast"]["forecastday"][0]["day"]["mintemp_c"].round(),
      ort_durumu: json["forecast"]["forecastday"][0]["day"]["condition"]["text"],
      ort_durumu_icon: json["forecast"]["forecastday"][0]["day"]["condition"]["icon"],
      day_date: json["forecast"]["forecastday"][0]["date"],
      date_epoch: json["forecast"]["forecastday"][0]["date_epoch"],


    );
  }


}
