import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/weather.dart';







class WeatherService{

  Future<Weather> getWeatherData(var latitude, var longitude) async{
  /* final queryParameters ={
      "key" : "8688fdf9b69f404c9cd91318230103",
      "q":String,
      "lang":"tr",
      "days":"7",




    };*/


//final uri =Uri.https("api.weatherapi.com","/v1/forecast.json",queryParameters,);
  /*
  final response= await https.get(uri);
  try {
    if (response.statusCode ==200){
      return Weather.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));


    }
    else{
      throw Exception("can not  get weather?");
    }
  } on Exception catch (e) {
    // TODO
    rethrow;
  }


*/
    var uri = Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=8688fdf9b69f404c9cd91318230103&q=$latitude,$longitude&lang=tr&days=7&aqi=no&alerts=yes") ;
    var response= await http.get(uri);
    try {
      if (response.statusCode ==200){

        return( Weather.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));


      }
      else{
        throw Exception("can not  get weather?");
      }
    } on Exception catch (e) {
      // TODO
      rethrow;
    }

}  }