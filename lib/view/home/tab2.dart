import 'package:flutter/material.dart';

import 'package:daily_verse/my_notification1.dart';
import 'package:daily_verse/reusable_components/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tap2 extends StatelessWidget {
  String lastVerse;
  Tap2({
    Key? key,
    required this.lastVerse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  MyMinutLisTile(myIcon: Icons.notifications,myTitle: "Notification",lastVerse: lastVerse,),
                  const SizedBox(height: 10,),
                  // MyDailyLisTile(myIcon: Icons.notifications,myTitle: "Notification",sub: "Per Day",),                  const SizedBox(height: 10,),
                  const SizedBox(height: 100,),
                  // const Verse(),
                ],
              ),
    );
  }
}


class MyMinutLisTile extends StatefulWidget {
  bool val= false;
  IconData myIcon;
  String myTitle;
  String lastVerse;

  MyMinutLisTile({
    Key? key,
    required this.myIcon,
    required this.myTitle,
    required this.lastVerse,
  }) : super(key: key);

  @override
  State<MyMinutLisTile> createState() => _MyMinutLisTileState();
}

class _MyMinutLisTileState extends State<MyMinutLisTile> {
  bool val= true;

  @override
  void initState() { 
    super.initState();
    loadData();
  }

  loadData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      val= prefs.getBool("activation")?? true;
    });
  }

  saveBool(bool newVal) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("activation", newVal);
    // setState(() {
    //   val = prefs.getBool("activation") ?? true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(elevation: 5,
          child: Container(color: purple,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                // subtitle: Text(widget.sub, style: const TextStyle(color: white,)),
                    leading: Icon(widget.myIcon,color: white,size: 30,),
                    title: Text(widget.myTitle , style: const TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 18),),
                    // subtitle: Text(sub, style: const TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 14),),
                    trailing: Switch(activeColor: white ,value: val, onChanged: (newVal)async{
                      
                      setState(()  {                       
                        val=newVal; 
                        saveBool(newVal);                 
                        // if(val == true){
                        //   localNotifyManager.showNotificationPerMinute(body: widget.lastVerse);
                        // }else{
                        //   localNotifyManager.cancelNotification(0);
                        // }
                      });
                    }),
                  ),
            ),
          ),
        ),
        
      ],
    );
  }
}
// val= prefs.getBool('activation') ?? true;
// prefs.setBool('activation',newVal);

class MyDailyLisTile extends StatefulWidget {

  IconData myIcon;
  String myTitle;
  String sub;

  MyDailyLisTile({
    Key? key,
    required this.myIcon,
    required this.myTitle,
    required this.sub,
  }) : super(key: key);

  @override
  State<MyDailyLisTile> createState() => _MyDailyLisTileState();
}

class _MyDailyLisTileState extends State<MyDailyLisTile> {
  bool val=false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(elevation: 5,
          child: Container(color: purple,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                subtitle: Text(widget.sub, style: const TextStyle(color: white,)),
                    leading: Icon(widget.myIcon,color: white,size: 30,),
                    title: Text(widget.myTitle , style: const TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 18),),
                    // subtitle: Text(sub, style: const TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 14),),
                    trailing: Switch(activeColor: white ,value: val, onChanged: (newVal){
                      setState(()  {
                        val=newVal;
                        if(val == true){
                          localNotifyManager.showNotificationPerDay(/*body: 'HELLO VARVOUR!'*/);
                        }else{
                          localNotifyManager.cancelNotification(0);
                        }
                      });
                    }),
                  ),
            ),
          ),
        ),
        
      ],
    );
  }
}
