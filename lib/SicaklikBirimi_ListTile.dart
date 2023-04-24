import 'package:flutter/material.dart';

enum SicaklikBirimi{ santigrat, fahrenhayt}
class SicaklikBirimi_ListTile extends StatefulWidget {
  SicaklikBirimi_ListTile({Key key}) : super(key: key);

  @override
  State<SicaklikBirimi_ListTile> createState() => _SicaklikBirimi_ListTileState();
}

class _SicaklikBirimi_ListTileState extends State<SicaklikBirimi_ListTile> {
  SicaklikBirimi _sicaklikBirimi = SicaklikBirimi.santigrat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sıcaklık Birimi",
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
            children: [
              RadioListTile<SicaklikBirimi>(
                title: Text("Santigrat",),
                groupValue: _sicaklikBirimi,
                value: SicaklikBirimi.santigrat,
                onChanged: (SicaklikBirimi value){setState(() {
                  _sicaklikBirimi = value;
                });},
              ),
             const Divider(
                height: 2,
                thickness: 2,
              ),

              RadioListTile<SicaklikBirimi>(
                title: Text("Fahrenhayt"),
                groupValue: _sicaklikBirimi,
                value: SicaklikBirimi.fahrenhayt,
                onChanged: (SicaklikBirimi value){setState(() {

                  _sicaklikBirimi = value ;
                });},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
