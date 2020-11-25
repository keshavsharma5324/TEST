import 'package:flutter/material.dart';
import 'package:life_wish/Utils/utilwediget.dart';
import 'package:life_wish/Utils/validator.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/theme/AppColor.dart';

import 'PhoneOtpScreen.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {


    return PhoneNumberScreenState();
  }

}

class PhoneNumberScreenState extends State {
  bool isHidePassword = true;
  IconData icon = Icons.remove_red_eye;
  TextEditingController phoneNumberController =
  new TextEditingController(text: "");
  final globalKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key: globalKey,
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset("assets/app_logo.png", height: 150, width: 150,),
                  SizedBox(
                    height: 10,
                  ),
                  phoneNumberForm(),

                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  phoneNumberForm() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 40,
                padding: EdgeInsets.only(left: 2,bottom: 4,),
                width: MediaQuery.of(context).size.width ,
                child: Text(AppLocalizations.of(context).translate('phone_number') ,style: TextStyle(color: Colors.white,fontSize: 30),),
              ),

              Container(
                height: 30,
                padding: EdgeInsets.only(left: 2,bottom: 4),
                width: MediaQuery.of(context).size.width ,
                child: Text(AppLocalizations.of(context).translate('please_share_phone_number') ,style: TextStyle(color: lite_blue_color,fontSize: 18),),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 4,top: 10),
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: AppLocalizations.of(context).translate('enter_phone_number'),
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ),

              Padding(

                padding: const EdgeInsets.only(left: 2,top: 16),
                child: RichText(
                    text: TextSpan(
                        text: AppLocalizations.of(context).translate('submission_6_digit_otp_verification'),
                        style: TextStyle(
                            fontSize: 14, color: lite_blue_color))),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 8,top: 20),
                height: 50,
                width:  MediaQuery.of(context).size.width - 60,
                child: RaisedButton(
                  color: dark_blue_color,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
                  ),
                  child: RichText(
                      text: TextSpan(
                          text: AppLocalizations.of(context).translate('submit'),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                  onPressed: () {

                   if(Validator.validateMobileNo(phoneNumberController.text)){
                     globalKey.currentState.showSnackBar(getSnackBar(AppLocalizations.of(context).translate('enter_valid_mobile_number'),AppLocalizations.of(context).translate('ok')));
                   }else {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => PhoneOtpScreen()),
                     );
                   }

                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}