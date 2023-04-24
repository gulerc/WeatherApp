import 'package:flutter/material.dart';
class Reklam extends StatefulWidget {
  const Reklam({Key key}) : super(key: key);

  @override
  State<Reklam> createState() => _ReklamState();
}

class _ReklamState extends State<Reklam> {
  bool light0 = true;
  bool light1 = true;



  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reklam",
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
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 5,),

              Text("Gizliliğinizi korurken sizin için yararlı olan kişiselleştirilmiş reklamlar sağlıyoruz. Kişiselleştirilmiş reklamları devre dışı bırakırsanız, yine aynı sayıda reklam alırsınız ancak bunlar sizinle daha az alakalı olabilir.", style: TextStyle(fontSize: 12.2),),

              SizedBox(height: 30,),

              SizedBox(
                width: 370,
                height: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      primary: Colors.black54,
                      alignment: Alignment.centerLeft),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Kişiselleştirilmiş Reklamlar"),
                          Text("Kişisel tercihlerinize göre reklamlar alın.",style: TextStyle(color: Colors.white54,fontSize: 12),)
                        ],
                      ),
                      Switch(value: light0,onChanged: (bool value){
                        setState(() {
                          light0 = value;
                        });
                      })
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10,),

              SizedBox(
                width: 370,
                height: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      primary: Colors.black54,
                      alignment: Alignment.centerLeft),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Üçüncü Taraf Reklamlar"),
                            Text("Reklamverenler, ürün veya hizmetlerinde gösterdiğiniz tercihlere göre bu uygulamada reklamlar gösterecek.",style: TextStyle(color: Colors.white54,fontSize: 12))
                          ],
                        ),
                      ),
                      Switch(value: light1,onChanged: (bool value){
                        setState(() {
                          light1 = value;
                        });
                      })
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
