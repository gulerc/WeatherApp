import 'package:HavaDurumu/Hakkinda.dart';

import 'package:HavaDurumu/SicaklikBirimi_ListTile.dart';
import 'package:flutter/material.dart';



class Ayarlar extends StatefulWidget {
  const Ayarlar({Key key}) : super(key: key);

  @override
  State<Ayarlar> createState() => _AyarlarState();
}
enum SicaklikBirimi{santigrat, fahrenhayt}
class _AyarlarState extends State<Ayarlar> {
  SicaklikBirimi _sicaklikBirimi = SicaklikBirimi.santigrat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ayarlar",
          style: TextStyle(color: Colors.black),
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisSize: MainAxisSize.max,
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 370,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      primary: Colors.black54,
                      alignment: Alignment.centerLeft),
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SicaklikBirimi_ListTile(),));},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sıcaklık Birimi"),
                      Icon(Icons.arrow_forward_ios),

                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      primary: Colors.black54,
                      alignment: Alignment.centerLeft),
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Hakkinda()));},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Hakkında"),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


