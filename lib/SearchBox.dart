

import 'package:HavaDurumu/main.dart';
import 'package:HavaDurumu/models/autocomplate_prediction.dart';
import 'package:HavaDurumu/s_weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/location_list_tile.dart';
import 'components/network_utilitiy.dart';
import 'models/place_auto_complate_response.dart';
class SearchBox extends StatefulWidget {
  const SearchBox({Key key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
List<AutocompletePrediction> placePredictions=[];
  //List<Autocomplete<PredictionsListView>> placePredictions =[];

  void placeAutocomplate(String query) async{
    Uri uri = Uri.https(
      "maps.googleapis.com",
      "/maps/api/place/autocomplete/json",
      {
        "input": query,
        "key": "AIzaSyCp07eoWSUMoxDwjqZuRhILKaTy9G5SfZQ",
      },
    );
    String response = await NetworkUtilitiy.fetchUrl(uri);
    if(response!= null){

      PlaceAutocompleteResponse result= PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if(result.predictions != null){
        setState(() {
          placePredictions = result.predictions;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,),),
      ),
      body: Column(
        children: [
        Form(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                onChanged: (value){
                  placeAutocomplate(value);
                  placePredictions;

                },
                textInputAction: TextInputAction.search,

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,),
                    borderRadius: BorderRadius.circular(50),

                  ),
                  hintText: "Konum Giriniz.",

                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SvgPicture.asset(
                      "assets/location.svg",
                      height: 16,
                      width: 16,

                    ),
                  ),
                ),
              ),
            ),

        ),
          //const Divider(
            //height: 4,
            //thickness: 4,
            //color: Colors.black,
          //),
          Expanded(
            child: ListView.builder(
              itemCount: placePredictions.length,
                itemBuilder: (context, index)=> LocationListTile(
                  press: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MyApp()));
                  },//Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));},

                  location: placePredictions[index].description,


            ),

            ),
          )
      ],),
    );
  }
}
