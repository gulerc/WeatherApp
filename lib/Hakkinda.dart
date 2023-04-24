import 'package:flutter/material.dart';

import 'Reklam.dart';
class Hakkinda extends StatefulWidget {
  const Hakkinda({Key key}) : super(key: key);

  @override
  State<Hakkinda> createState() => _HakkindaState();
}

class _HakkindaState extends State<Hakkinda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hakkında",
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
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Column(
               children: [
                 SizedBox(height: 50,),
                 Stack(
                   children: [
                     Image.asset(
                       "assets/havadurumu.png",
                       height: 100,
                       width: 100,
                     ),
                   ],
                 ),
                 SizedBox(height: 10,),
                 Container(
                   child: Text("Hava Durumu"),
                 ),
                 Container(
                   child: Text("24.02.2023",),
                 ),
                 SizedBox(height: 50,),
                 SizedBox(
                   width: 370,
                   height: 50,
                   child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15)),
                         primary: Colors.black54,
                         alignment: Alignment.centerLeft),
                     onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Reklam(),));},
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Kişiselleştirilmiş Reklamlar"),
                         Icon(Icons.arrow_forward_ios)
                       ],
                     ),
                   ),
                 ),
               ],
             ),
           ],
         ),
        ),
      ),
    );
  }
}
