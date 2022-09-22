import 'dart:async';
import 'dart:math';

import 'package:daily_verse/my_notification1.dart';
import 'package:daily_verse/reusable_components/background.dart';

import 'package:daily_verse/view/home/tab2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daily_verse/reusable_components/colors.dart';
import 'tab1.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:workmanager/workmanager.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool? notifSwitcher;

  // loadData() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     notifSwitcher= prefs.getBool("activation");
  //   });
  // }


  @override
  void initState() {
    // Workmanager().registerPeriodicTask("1", "per 15 min", frequency: Duration(minutes: 15));
    // Workmanager().registerPeriodicTask("2", "per day", frequency: Duration(days: 1));
    super.initState();
    // loadData();
    setVerse();
    start();
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(setOnNotificationClick);
  }
  


  onNotificationReceive(ReceiveNotification notification){
    // print('NOTIFICATION RECEIVED: ${notification.id}');
  }

  setOnNotificationClick(String payload){
    // print('PAYLOAD $payload');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return const Home();
    }));
  }

    void setVerse() async{
    // String x= verses[Random().nextInt(verses.length)];
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lastVerse= prefs.getString('lastVerse') ?? x;
      prefs.setString('lastVerse',lastVerse);
    });
  }

  List<String> verses= [
  '"In the world you will have tribulation. But take heart; I have overcome the world." John 16:33',
  '"So do not fear, for I am with you; do not be dismayed, for I am your God. I will strengthen you and help you; I will uphold you with my righteous right hand." Isaiah 41:10',
  '"88  Be strong and courageous. Do not be frightened, and do not be dismayed, for the LORD your God is with you wherever you go." Joshua 1:9',
  '"So do not worry, saying, *What shall we eat?* or *What shall we drink?* or *What shall we wear?* For the pagans run after all these things, and your heavenly Father knows that you need them. But seek first His kingdom and His righteousness, and all these things will be given to you as well. Therefore do not worry about tomorrow, for tomorrow will worry about itself. Each day has enough trouble of its own." Matthew 6:31–34',
  '"For I, the LORD your God, hold your right hand; it is I who say to you, *Fear not, I am the one who helps you.*" Isaiah 41:13',
  '"When I thought, "My foot slips," Your steadfast love, O LORD, helped me up. When the cares of my heart are many, Your consolations cheer my soul." Psalm 94:18–19',
  '"Humble yourselves, therefore, under the mighty hand of God so that at the proper time He may exalt you, casting all your anxieties on Him, because He cares for you." 1 Peter 5:6–7',
  '"Now to him who is able to do immeasurably more than all we ask or imagine, according to his power that is at work within us." Ephesians 3:20',
  '"May the God of hope fill you with all joy and peace as you trust in him, so that you may overflow with hope by the power of the Holy Spirit." Romans 15:13',
  '"The Lord is my light and my salvation; whom shall I fear? The Lord is the stronghold of my life; of whom shall I be afraid?" Psalm 27:1',
  ];
  
  String lastVerse="";
  String x='"But the fruit of the Spirit is love, joy, peace, forbearance, kindness, goodness, faithfulness, gentleness and self-control. Against such things there is no law." Galatians 5:22-23';
  int rndm=0;
  
  
  Timer? timer;
  Future<String> start() async {final prefs = await SharedPreferences.getInstance();
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        rndm =Random().nextInt(verses.length-1);
        x= verses[rndm];
        lastVerse=x;        
        prefs.setString('lastVerse',x);
        notifSwitcher= prefs.getBool("activation");
        if(notifSwitcher == true){
          localNotifyManager.showNotification(body: lastVerse);
        }else{localNotifyManager.cancelNotification(0);}
      });

    });
    return lastVerse;
  }

    void getVerse() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lastVerse= prefs.getString('lastVerse')!;
    });    
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(length: 2,
          child: Scaffold(
            appBar: AppBar(toolbarHeight: 5,
              backgroundColor: purple,
              bottom: const TabBar(indicatorColor: white,
                tabs: [
              Tab(icon: Icon(Icons.home, size: 30,),text: "Home",),
              Tab(icon: Icon(Icons.settings, size: 30,),text: "Setting",),
              ],),),
              body: Stack(
                children: [ const Backg(),
                   TabBarView(
                    children: [
                        SingleChildScrollView(child: Tap1(lastVerse: lastVerse,)),
                        SingleChildScrollView(child: Tap2(lastVerse: lastVerse,)),
                    ],
                  ),
                ],
              ),
            ),
        ));
  }
}


  // String? lastVerse;

  //   void getVerse() async{
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     lastVerse= prefs.getString('lastVerse')!;
  //   });    
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