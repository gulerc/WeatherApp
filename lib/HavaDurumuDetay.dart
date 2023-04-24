


import 'dart:convert';
import 'dart:ui';

import 'package:HavaDurumu/models/weather.dart';
import 'package:HavaDurumu/services/getLocation.dart';
import 'package:HavaDurumu/services/weather_service.dart';

import 'package:flutter/material.dart';


import 'package:intl/intl.dart';
import 'package:moon_phase/moon_widget.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';

import 'models/autocomplate_prediction.dart';

class HavaDurumuDetay extends StatefulWidget {
  const HavaDurumuDetay({Key key}) : super(key: key);

  @override
  State<HavaDurumuDetay> createState() => _HavaDurumuDetayState();
}

class _HavaDurumuDetayState extends State<HavaDurumuDetay> {
  List<int> minTemperatureForecast = List.filled(7, 0);
  List<int> maxTemperatureForecast = List.filled(7, 0);
  List<String> ConditionIconForecast = List.filled(7, '');
  String ConditionIcon="";
  String condition="";
  List<AutocompletePrediction> placePredictions = [];
  WeatherService weatherService = WeatherService();
  var weather;
  var temperature="";

  void initState() {
    info();
    super.initState();

    //String apiKey = "AIzaSyCp07eoWSUMoxDwjqZuRhILKaTy9G5SfZQ";
  }

/*
  String Moonrise(final moonrise){
    DateTime tempdate=new DateFormat("hh:mm").parse(moonrise);
    String x= DateFormat.Hm().format(tempdate);

    return x;
  }
  String Moonset(final moonset){
    DateTime tempdate=new DateFormat("hh:mm a").parse(moonset);
    String x= DateFormat.Hm().format(tempdate);

    return x;
  }

  */
  String getTime(final hour_time_epoch) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(hour_time_epoch * 1000);
    String x = DateFormat("Hm").format(time);
    return x;
  }


  List hourlyWeatherForecast = [];
  String currentWeatherStatus = '';
  List dailyWeatherForecast = [];


 info()async{
   var position = await GetPosition();
   weather = await weatherService.getWeatherData(position.latitude, position.longitude,);


   print(weather.name);


     }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
info();
    return Scaffold(
      body: FutureBuilder(
        future: info(),
        builder: ((context,snapshot) {
          return Container(
            child: Stack(
              children: [
                Image.asset(
                  "assets/cloudy.jpg",
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.black38),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${weather?.name},"+"${weather?.region}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "${weather?.temperatureC}"+ "\u2103",
                        style: TextStyle(
                          fontSize: 85,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                      "${weather?.maxtemp_c}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "/" + "${weather?.mintemp_c}"+ "\u2103",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${weather?.condition}",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Expanded(
                        child: SingleChildScrollView(

                          child: Column(
                            children: [
                              //saatlik hava durumu
                              Container(
                                height: 90,
                                width: 370,
                                margin: EdgeInsets.only(right: 10,left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white24,
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(

                                          children: [
                                            for (var index =0; index<24; index++)
                                              Container(
                                                  padding: EdgeInsets.symmetric(vertical: 10),
                                                  margin: const EdgeInsets.only(right: 5,left: 20),
                                                  width: 40,
                                                  height: MediaQuery.of(context).size.height * 0.25,
                                                  color: Colors.transparent,

                                                  child:
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(DateFormat.H().format(DateTime.now().add(Duration(hours: index)))+":00",style: TextStyle(color: Colors.white),),
                                                      Image.network("https:${weather?.hour_icon}",width: 30,),
                                                      Text("${weather?.hour_temp_c}\u2103",style: TextStyle(fontSize: 16,color: Colors.white),),

                                                    ],
                                                  )),

                                          ],
                                        ),
                                      ),

                                      // Text("Saatlik hava durumu"),
                                      //Text("${weather?.hour_temp_c}"),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //Haftalık hava durumu
                              Container(
padding: EdgeInsets.only(left:16),
                                height: 180,
                                width: 370,
                                margin: EdgeInsets.only(right: 10,left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white24,
                                ),

                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                     itemCount: 1,
                                      itemBuilder: (BuildContext context, int index){
                                     // String today = DateTime.now().toString().substring(0,10);

                                      return GestureDetector(
                                        onTap: (){
                                          print(index);
                                        },
                                        child: Row(
                                          children: <Widget>[//tarih,ort_durumu_icon,ort_durumu,maks_derece,min_derece

                                            for(var i =0; i<7; i++)
                                              forecastElement(i,weather?.ort_durumu_icon[index],weather?.maks_derece,weather?.min_derece),
                                              //forecastElement(index,weather.condition_icon,getForecastWeather(index)["weatherName"],weather.maxtemp_c,weather.mintemp_c),// "${weather?.ort_durumu_icon[index]}", "${weather?.ort_durumu[index]}",weather?.maks_derece, "${min_dereceForecast}")


                                         // forecastElement(0,condition_iconForecast,weather?.condition,maxTemperatureForecast,minTemperatureForecast),
                                          //forecastElement(1,condition_iconForecast,"${weather?.condition}",maxTemperatureForecast,minTemperatureForecast),
                                          //  forecastElement(3,weather.ort_durumu_icon[2],"${weather?.ort_durumu[3]}","${weather.maks_derece[3]}","${weather.min_derece[3]}"),
                                           // forecastElement(4,weather.ort_durumu_icon[4],"${weather?.ort_durumu[4]}","${weather.maks_derece[4]}","${weather.min_derece[4]}"),
                                         //   forecastElement(5,weather.ort_durumu_icon[5],"${weather?.ort_durumu}","${weather.maks_derece[1]}","${weather.min_derece[1]}"),
                                            // forecastElement(6,weather.ort_durumu_icon[6],"${weather?.ort_durumu}","${weather.maks_derece[1]}","${weather.min_derece[1]}"),
                                           // forecastElement(7,weather.ort_durumu_icon[7],"${weather?.ort_durumu}","${weather.maks_derece[1]}","${weather.min_derece[1]}"),
                                            //forecastElement(8,weather.ort_durumu_icon[8],"${weather?.ort_durumu}","${weather.maks_derece[1]}","${weather.min_derece[1]}"),


                                          ],
                                        ),
                                      );
                                      }
                                  ),

                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //Genişletilmiş tahmin
                              SizedBox(
                                width: 370,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                      primary: Colors.white24,
                                      alignment: Alignment.centerLeft),
                                  onPressed: () async {
                                    const Url =
                                        "https://mgm.gov.tr/tahmin/il-ve-ilceler.aspx#/";
                                    if (await canLaunch(Url)) {
                                      await launch(Url);
                                    } else {
                                      throw "link açılmıyor";
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.calendar_month),
                                      Text("Genişletilmiş tahmin "),
                                      Icon(Icons.arrow_forward_ios)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "YARDIMCI BİLGİLER",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      const Url =
                                          "https://mgm.gov.tr/tahmin/gunluk-tahmin.aspx";
                                      if (await canLaunch(Url)) {
                                        await launch(Url);
                                      } else {
                                        throw "link açılmıyor";
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "DİĞER ",
                                          style: TextStyle(color: Colors.white54),
                                        ),
                                        Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //Yardımcı Bilgiler kısmı
                              Container(
                                height: 200,
                                width: 370,
                                margin: EdgeInsets.only(right: 10,left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white24,
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(right: 10,left: 14),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          //Nem
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Image.asset(
                                                "assets/nem.png",
                                                height: 30,
                                                width: 30,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Nem",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "%" + "${weather?.humidity}",
                                                style:
                                                TextStyle(color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          //Hissedilen
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Image.asset("assets/derece.png",
                                                  height: 30,
                                                  width: 30,
                                                  color: Colors.white),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Hissedilen",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("${weather?.feelslike_c}" +
                                                  "\u2103",style: TextStyle(color: Colors.white),),
                                            ],
                                          ),
                                          //Rüzgar hızı
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Image.asset("assets/ruzgar.png",
                                                  height: 30,
                                                  width: 30,
                                                  color: Colors.white),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Rüzgar hızı",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "${weather?.wind_kph}"+ " km/sa.",
                                                style:
                                                TextStyle(color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          //Rüzgar yönü
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Image.asset("assets/ruzgar-yonu.png",
                                                  height: 30,
                                                  width: 30,
                                                  color: Colors.white),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Rüzgar yönü",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "${weather?.wind_dir}",
                                                style:
                                                TextStyle(color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      //UV
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "UV",
                                            style: TextStyle(fontSize: 30,color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "UV indeksi",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${weather?.uv}",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "GÜN DOĞUMU VE GÜN BATIMI",
                                    style: TextStyle(color: Colors.white),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //Gün Doğumu ve gün batımı
                              Container(
                                height: 90,
                                width: 370,
                                margin: EdgeInsets.only(right: 10,left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white24,
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(right: 10,left: 10),
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Text("Gün doğumu " + "${weather?.sunrise}",style: TextStyle(color: Colors.white),),
                                          Text("Gün batımı " + "${weather?.sunset}",style: TextStyle(color: Colors.white),),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          MoonWidget(
                                            date: DateTime.now(),
                                            earthshineColor:
                                            Colors.blueGrey.shade900,
                                            moonColor: Colors.amber,
                                          ),
                                          Text("${weather?.moon_phase}",style: TextStyle(color: Colors.white),),
                                          // Text(Intl.withLocale("tr", () => moon_phase)),

                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [

                                          Text("Ay doğumu " + "${weather?.moonrise}",style: TextStyle(color: Colors.white),),
                                          Text("Ay batımı " + "${weather?.moonset}",style: TextStyle(color: Colors.white),)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        })
      ),
    );
  }

  Widget forecastElement(int index, ort_durumu_icon, maxtemp_c, mintemp_c){//,ort_durumu_icon,ort_durumu,maks_derece,min_derece) {
    var now = new DateTime.now();
    var oneDayFromNow = now.add(new Duration(days: index ));
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(right: 20, bottom: 10, ),
     width: 80,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:<Widget> [
          Text(new DateFormat.E("tr").format(oneDayFromNow), style: TextStyle(color: Colors.white, fontSize: 20),),
          Text(new DateFormat.MMMd("tr").format(oneDayFromNow), style: TextStyle(color: Colors.white, fontSize: 15),),
          Image.network("https:${weather?.ort_durumu_icon}" , width: 35,height:35, ),


            Text(weather?.ort_durumu,style: TextStyle(color: Colors.white,fontSize:8 ),),
            Text("${weather?.maks_derece}\u2103",style: TextStyle(color: Colors.white, fontSize: 15),),
            Text("${weather?.min_derece}\u2103",style: TextStyle(color: Colors.white, fontSize: 15),),




        ],
      ),

    );

  }



}
