


import 'dart:convert';

import 'package:HavaDurumu/HavaDurumuDetay.dart';
import 'package:HavaDurumu/components/location_list_tile.dart';
import 'package:HavaDurumu/models/place_auto_complate_response.dart';
import 'package:HavaDurumu/services/getLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart' ;
import 'package:HavaDurumu/services/weather_service.dart';
import 'package:HavaDurumu/s_weather.dart';
import 'package:HavaDurumu/SearchBox.dart';

import 'models/autocomplate_prediction.dart';
import 'models/weather.dart';


class s_weather extends StatelessWidget {


  String formattedDate = DateFormat('kk:mm a – dd/MM/yyyy').format(DateTime.now());
  Placemark placemark = Placemark();
  WeatherService weatherService = WeatherService();
  var weather;

  SearchBox selectedCity = SearchBox();

  info()async{
    var position = await GetPosition();
    weather = await weatherService.getWeatherData(position.latitude, position.longitude);

    return weather;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: info(),
      builder: ((context,snapshot) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 160,
                        ),

                        Text(
                          "${weather?.name}, "+"${weather?.region}",

                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //Text(formattedDate),
                        Text(
                          '$formattedDate',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Container(margin: EdgeInsets.only(),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 120,),
                          TextButton(
                            child: Text('${weather?.temperatureC}' + " \u2103",style: TextStyle(
                              fontSize: 85,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),),
                            onPressed: (){ Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HavaDurumuDetay()));},

                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Image.network("https:${weather?.condition_icon}"),
                              Expanded(
                                child: Text(
                                  '${weather?.condition}',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300
                                    ,),),
                              ),

                            ],
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "assets/derece.png",
                              color: Colors.white,
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Nem",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "%" + "${weather?.humidity}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/ruzgar.png",
                              color: Colors.white,
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Rüzgar Hızı",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "${weather?.wind_kph}" + "km/sa.",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/yagmur.png",
                              color: Colors.white,
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Yağmur",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "%""${(weather?.precip_mm)}",
                              style: TextStyle(color: Colors.white),

                            ),
                          ],
                        ),

                        //Text(formattedDate),
                      ],
                    ),
                  )
                ],
              ),

            ],
          ),
        );
      }),
    );


  }
}
