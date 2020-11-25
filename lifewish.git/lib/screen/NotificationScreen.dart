import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/theme/AppColor.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationScreenState();
  }
}

class NotificationScreenState extends State<NotificationScreen> {
  String title = "Title";
  String helper = "helper";

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (message) async{
        setState(() {
          title = message["notification"]["title"];
          helper = "You have recieved a new notification";
        });

      },
      onResume: (message) async{
        setState(() {
          title = message["data"]["title"];
          helper = "You have open the application from notification";
        });

      },
      onLaunch: (message) async{
        setState(() {
          title = message["data"]["title"];
          helper = "You have open the application from notification";
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: true,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            AppLocalizations.of(context).translate('notification'),
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: transparent_color,
        ),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return getNotificationItem();

          }
      ) ,
    ));
  }

  getNotificationItem(){
    return Column(
      children: <Widget>[
        Container(height: 1.5,color: dark_blue_color,),
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Text(helper),
            Text(
              '$title',
              style: Theme.of(context).textTheme.display1,
            ),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Text("18\nAug",style: TextStyle(fontSize: 20   , color: primaryColor )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Hello ',
                    style: TextStyle(fontSize: 18, color: Colors.white ),
                    children: <TextSpan>[
                      TextSpan(text: '\nBy :', style: TextStyle(fontSize: 20, color: lite_blue_color )),
                      TextSpan(text: '1234567890', style: TextStyle(fontSize: 16, color: lite_blue_color )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

      ],
    );
  }

}
