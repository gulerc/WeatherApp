


import 'package:HavaDurumu/HavaDurumuDetay.dart';
import 'package:HavaDurumu/SearchBox.dart';

import 'package:HavaDurumu/components/network_utilitiy.dart';
import 'package:HavaDurumu/models/weather.dart';
import 'package:HavaDurumu/services/weather_service.dart';
import 'package:HavaDurumu/s_weather.dart';
import 'package:HavaDurumu/widgets/slider_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'Ayarlar.dart';

import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

import 'models/autocomplate_prediction.dart';
import 'models/place_auto_complate_response.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          const Locale('tr')
        ],
      debugShowCheckedModeBanner: false, //debug yazısını kaldırmak için.

      theme: ThemeData(
        brightness: Brightness.light, //uygulama karanlık mı parlak mı
        //primarySwatch: Colors.blue,//Uygulamanın birincil rengi
      ),

      home: FlutterSplashScreen.fadeIn(
        backgroundColor: Colors.white,

        onInit: () {
          debugPrint("On Init");
        },
        onEnd: () {
          debugPrint("On End");
        },
        childWidget: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset("assets/havadurumu.png"),
        ),
        onAnimationEnd: () => debugPrint("On Fade In End"),
        defaultNextScreen:  MyHomePage(title: "Hava Durumu"),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({key, this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  List<AutocompletePrediction> placePredictions=[];
  int _currentPage = 0;

  WeatherService weatherService = WeatherService();
  Weather weather = Weather();
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('kk:mm a – dd/MM/yyyy').format(DateTime.now());
  String currentWeather="";
  num tempC = 0;
  num tempF = 0;
  num humidity = 0;
  num wind_kph = 0;
  num precip_mm = 0;
  String city="";





//  String bgImg;
//String? bgImg;


  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;


    });
  }



  final PageController _pageController = PageController(
    initialPage: 1,
  );

  //String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now());
  final dio = Dio();

  @override


  void dispose() {
    _pageController.dispose();
    super.dispose();
  }





  Widget build(BuildContext context) {

    if(currentWeather=="Sunny"){
      currentWeather = "assets/sunny.jpg";
    }else if(currentWeather=="Night"){
      currentWeather = "assets/night.jpg";
    }else if(currentWeather=="Light Rain"){
      currentWeather = "assets/rainy.jpg";
    } else if(currentWeather=="Rain"){
      currentWeather = "assets/rainy.jpg";
    }else if(currentWeather=="Partly cloudy"){
      currentWeather = "assets/sunny.jpg";
    } else{
      currentWeather = "assets/cloudy.jpg";
    }
    return RefreshIndicator(
          key: _refreshIndicatorKey,
          edgeOffset: 0,
          displacement: 100,
          color: Colors.white,
          backgroundColor: Colors.black,
          //strokeWidth: 4.0,
          onRefresh: () async {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyApp()));
            await Future.delayed(Duration(seconds: 2),() => null);
            },

      child: Scaffold(

              extendBodyBehindAppBar: true,
              appBar: AppBar(

                backgroundColor: Colors.transparent,
                //backgroundColor: Color(0x44000000),
                elevation: 0,
                brightness: Brightness.light,
                leading: IconButton(
                  //alignment: Alignment(-106, 0),
                  icon: new Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 26.0,
                  ),

                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchBox()));

                    //showSearch(context: context, delegate: SearchBox());
                  },
                ),
                //backgroundColor: Colors.white,
                actions: [

                  PopupMenuButton(
                      //3 nokta iconu
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),

                      // icon: Icon(Icons.book)
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem<int>(
                            value: 0,
                            child: Text("Ayarlar"),
                          ),

                        ];
                      },
                      onSelected: (value) {
                        if (value == 0) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Ayarlar()));
                          print("Ayarlar seçildi.");
                        }
                      }),

                ],
                //title: Text(widget.title),
              ),

              body:  PageView(

                scrollDirection: Axis.vertical,
                children: [
                  PageView(
                      physics: const AlwaysScrollableScrollPhysics(),
                          controller: _pageController,

                          children: [

                            Container(
                              child: Stack(
                                children: [

                                  Image.asset(
                                   //"assets/cloudy.jpg",
                                    "${currentWeather}",
                                    //"${weather?.condition}".replaceAll("", ""),
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(color: Colors.black38),
                                  ),

                              /*    Container(
                                    margin: EdgeInsets.only(top: 140, left: 15),
                                    child: Row(
                                      children: [
                                        //SliderDots
                                        for (int i = 0; i<4; i++)
                                          if (i == _currentPage)
                                            SliderDots(true)
                                          else
                                            SliderDots(false)
                                      ],
                                    ),
                                  ),*/

s_weather(),
                                /*  PageView.builder(
                                    scrollDirection: Axis.horizontal,
                                   onPageChanged: _onPageChanged,
                                   // itemCount: placePredictions.length,
                                    itemBuilder: (ctx,i)=> s_weather(i),
                                  ),*/


                                  //  PageView.builder(
                                  // scrollDirection: Axis.horizontal,

                                  //itemBuilder: (context, index)=>
                                  //),
                                ],
                              ),
                            ),



                          ],
                        ),

                  HavaDurumuDetay(),
                ],
              ),
              ),
    );


            // This trailing comma makes auto-formatting nicer for build methods.


  }


}

/*class AutocompletePrediction {
}

class GooglePlace {
  GooglePlace(String apiKey);

  get autocomplete => null;
}*/
