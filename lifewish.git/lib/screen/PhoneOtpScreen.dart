import 'package:flutter/material.dart';
import 'package:life_wish/Utils/utilwediget.dart';
import 'package:life_wish/Utils/validator.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/theme/AppColor.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class PhoneOtpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhoneOtpScreenState();
  }
}

class PhoneOtpScreenState extends State {
  TextEditingController _otpController =
  new TextEditingController(text: "");
  final _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: SafeArea(
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      "assets/app_logo.png",
                      height: 150,
                      width: 150,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      padding: EdgeInsets.only(
                        left: 2,
                        bottom: 4,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        AppLocalizations.of(context).translate('phone_number_verification'),
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2, top: 4),
                      child: RichText(
                          text: TextSpan(
                              text:
                                  AppLocalizations.of(context).translate('fill_6_digit_otp'),
                              style: TextStyle(
                                  fontSize: 14, color: lite_blue_color))),
                    ),
                    SizedBox(height: 16,),
                    PinCodeTextField(
                      controller: _otpController,
                      autofocus: true,
                      hideCharacter: false,
                      highlight: true,
                      highlightColor: dark_blue_color,
                      defaultBorderColor: lite_blue_color,
                      hasTextBorderColor: lite_blue_color,
                      pinBoxWidth: 40,
                      pinBoxHeight: 40,
                      maxLength: 6,
                      maskCharacter: "😎",
                      onTextChanged: (text) {
                        setState(() {});
                      },
                      onDone: (text) {

                      },
                      wrapAlignment: WrapAlignment.spaceAround,
                      pinBoxDecoration:
                          ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                      pinTextStyle:
                          TextStyle(fontSize: 18.0, color: Colors.white),
                      pinTextAnimatedSwitcherTransition:
                          ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                      pinTextAnimatedSwitcherDuration:
                          Duration(milliseconds: 300),
//                    highlightAnimation: true,
                      highlightPinBoxColor: Colors.red,
                      highlightAnimationBeginColor: Colors.black,
                      highlightAnimationEndColor: Colors.white12,
                      keyboardType: TextInputType.number,
                    ),

                    SizedBox(height: 16,),
                    
                    Container(
                      margin: EdgeInsets.only(bottom: 8, top: 20),
                      height: 50,
                      width: MediaQuery.of(context).size.width - 60,
                      child: RaisedButton(
                        color: dark_blue_color,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(4, 4)),
                        ),
                        child: RichText(
                            text: TextSpan(
                                text: AppLocalizations.of(context).translate('verify'),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                        onPressed: () {

                          if(Validator.validateOTP(_otpController.text)){

                            _globalKey.currentState.showSnackBar(getSnackBar(AppLocalizations.of(context).translate('enter_valid_otp'),AppLocalizations.of(context).translate('ok')));

                          }else {
                            Navigator.popUntil(context, ModalRoute.withName('/loginScreen'));

                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
