// import 'package:daily_verse/my_notification.dart';
import 'package:daily_verse/my_notification1.dart';
// import 'package:daily_verse/view/home/tab1.dart';
import 'package:flutter/material.dart';

class Trial extends StatefulWidget {
  const Trial({Key? key}) : super(key: key);

  @override
  State<Trial> createState() => _TrialState();
}

class _TrialState extends State<Trial> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(setOnNotificationClick);
  }

  onNotificationReceive(ReceiveNotification notification){
    // print('NOTIFICATION RECEIVED: ${notification.id}');
  }

  setOnNotificationClick(String payload){
    // print('PAYLOAD $payload');
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
    //   return const Tap1();
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async{
                  await localNotifyManager.showNotificationPerMinute( /*body: 'HELLO VARVOUR!'*/);
                }
                // => MyNotification.showNotification(
                //     title: 'Message of the day!', body: 'HELLO VARVOUR!')
                ,
                child: const Text('LOCAL NOTIFICATION'))
          ],
        ),
      ),
    );
  }
}
