import 'package:flutter/material.dart';
import 'package:life_wish/Utils/utilwediget.dart';
import 'package:life_wish/Utils/validator.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/theme/AppColor.dart';

class ChangePasswordScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ChangePasswordScreenState();
  }

}

class ChangePasswordScreenState extends State <ChangePasswordScreen>{
  bool isHidePassword = true;
  IconData icon = Icons.remove_red_eye;
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController passwordController = new TextEditingController(text: "");
  TextEditingController confirmPasswordController = new TextEditingController(text: "");
  FocusNode secondFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: globalKey,
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
            title: Text(AppLocalizations.of(context).translate('change_password'),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            centerTitle: true,
            backgroundColor: transparent_color,
          ),
        ),
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

                  changePasswordForm(),

                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  changePasswordForm() {
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
                child: Text(AppLocalizations.of(context).translate("change_password") ,style: TextStyle(color: Colors.white,fontSize: 30),),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: AppLocalizations.of(context).translate('new_password'),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: new IconButton(
                          icon: new Icon(icon),
                          onPressed: () {
                            hidePassword();
                          }),
                    ),
                    textInputAction: TextInputAction.done,
                    obscureText: isHidePassword,
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(secondFocusNode);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: AppLocalizations.of(context).translate('confirm_new_password'),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: new IconButton(
                          icon: new Icon(icon),
                          onPressed: () {
                            hidePassword();
                          }),
                    ),
                    textInputAction: TextInputAction.done,
                    obscureText: isHidePassword,
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(secondFocusNode);
                    },
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 8,top: 16),
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
                    validateFrom();
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  validateFrom(){
    if(Validator.validatePassword(passwordController.text)){
      globalKey.currentState.showSnackBar(getSnackBar(AppLocalizations.of(context).translate('enter_valid_pass') ,AppLocalizations.of(context).translate('ok')));
    }else if(Validator.validatePassword(passwordController.text)){
      globalKey.currentState.showSnackBar(getSnackBar(AppLocalizations.of(context).translate('enter_valid_pass') ,AppLocalizations.of(context).translate('ok')));
    }
    else{
      Navigator.pop(context);
    }
  }

  hidePassword() {
    if (isHidePassword) {
      isHidePassword = false;
      icon = Icons.visibility_off;
    } else {
      isHidePassword = true;
      icon = Icons.remove_red_eye;
    }
    setState(() {});
  }

}