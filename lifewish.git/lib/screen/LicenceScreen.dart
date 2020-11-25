import 'package:flutter/material.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/theme/AppColor.dart';

class LicenceScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return LicenceScreenState();
  }

}

class LicenceScreenState extends State<LicenceScreen>{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              automaticallyImplyLeading: true,
              leading: GestureDetector(
                child: Icon(Icons.arrow_back_ios),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(AppLocalizations.of(context).translate('licence'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              centerTitle: true,
              backgroundColor: transparent_color,
            ),
          ),
          body: Column(
            children: <Widget>[

              ListTile(
                title: Text('1. ResponsiveScreenFlutter',
                    style: TextStyle(fontSize: 18, color: lite_blue_color)),
                subtitle: Text('A new way to use percentage on flutter to optimze design',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),

              ListTile(
                title: Text('2. pin_code_text_field',
                    style: TextStyle(fontSize: 18, color: lite_blue_color)),
                subtitle: Text('A short and simple permissive license with conditions only requiring preservation of copyright and license notices. Licensed works, modifications, and larger works may be distributed under different terms and without source code.',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),

              ListTile(
                title: Text('3. Badges for Flutter',
                    style: TextStyle(fontSize: 18, color: lite_blue_color)),
                subtitle: Text('A permissive license whose main conditions require preservation of copyright and license notices. Contributors provide an express grant of patent rights. Licensed works, modifications, and larger works may be distributed under different terms and without source code.',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              ListTile(
                title: Text('4. Email validator',
                    style: TextStyle(fontSize: 18, color: lite_blue_color)),
                subtitle: Text('A short and simple permissive license with conditions only requiring preservation of copyright and license notices. Licensed works, modifications, and larger works may be distributed under different terms and without source code.',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),


            ],
          ),
        ));
  }

}