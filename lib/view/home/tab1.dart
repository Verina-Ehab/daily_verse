import 'package:flutter/material.dart';
import 'package:daily_verse/reusable_components/colors.dart';
import 'package:share_plus/share_plus.dart';
// import 'dart:async';
// import 'dart:math';
//  import 'package:daily_verse/my_notification.dart';
// import 'package:daily_verse/my_notification1.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Tap1 extends StatelessWidget {
  String lastVerse;

  Tap1({
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
                  Verse(lastVerse: lastVerse),
                  const SizedBox(height: 100,),
                ],
              ),
    );
  }
}

class Verse extends StatefulWidget {
  String lastVerse;

  Verse({
    Key? key,
    required this.lastVerse,
  }) : super(key: key);

  @override
  State<Verse> createState() => _VerseState();
}

class _VerseState extends State<Verse> {


  void shareVerse() async{
    await Share.share(widget.lastVerse);
  }

  @override
  Widget build(BuildContext context) {
    return Card(elevation: 5,
      child: Container(color: purple,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // const SizedBox(height: 10,),
              ListTile(
                leading: const Icon(Icons.message ,color: white,size: 30,),
                title: const Padding(
                  padding: EdgeInsets.symmetric(vertical:15.0),
                  child: Text("VERSE of the day!" , style: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 14),),
                ),
                subtitle: Text(widget.lastVerse, style: const TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 20),),
              ),
              const SizedBox(height: 75,),
              Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                children: [CircleAvatar(radius: 28,backgroundColor: Colors.black12,child: IconButton(onPressed: shareVerse, icon: const Icon(Icons.share,color: white,size: 35,))),
                const SizedBox(width: 10,),
                const Text("Click to share your verse", style: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 14),)],),
                const SizedBox(height: 30,),
                // ElevatedButton(onPressed: () async => await localNotifyManager.showNotificationPerMinute( body: widget.lastVerse), child: Container(color: white,))
            ],
          ),
        ),
      ),
    );
  }
  
}

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   timer?.cancel();
  //   super.dispose();
  // }

  // FlutterLocalNotificationsPlugin? localNotification;
  
  // void callbackDispatcher(){
  //   var AndroidInitialization =AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var iosInitialization =IOSInitializationSettings();

  //   var initializationSetting = InitializationSettings(android: AndroidInitialization, iOS: iosInitialization);

  //   WidgetsFlutterBinding.ensureInitialized();

  //   localNotification?.initialize(initializationSetting);


  //   Workmanager().executeTask((taskName, inputData) {
  //     showNotification();
  //     return Future.value(true);
  //   });
  // }

  // Future showNotification() async{
  //   AndroidNotificationDetails androidChannel = AndroidNotificationDetails('$rndm.0', 'Daily Verse', importance: Importance.max,
  //   priority: Priority.high, playSound: true, enableVibration: true);

  //   var iOSchannel= IOSNotificationDetails(
  //     threadIdentifier: 'thread_id',
  //   );

  //   var platformChannel= NotificationDetails(android: androidChannel, iOS: iOSchannel);

  //   await localNotification?.show( 0, "Daily Verse", lastVerse , platformChannel);
  // }
