import 'package:flutter/material.dart';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:life_wish/Utils/utilwediget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lang/app_localizations.dart';
import '../repository/AppRepository.dart';
import '../screen/SingUpScreen.dart';
import '../theme/AppColor.dart';
import '../theme/life_wish_icons.dart';
import '../viewmodels/LoginViewModel.dart';
import '../widgets/PrimaryButton.dart';

import 'ForgotPasswordScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool isHidePassword = true;
  IconData icon = Icons.remove_red_eye;
  TextEditingController emailTextController =
      new TextEditingController(text: "");
  TextEditingController passwordTextController =
      new TextEditingController(text: "");
  FocusNode secondFocusNode = new FocusNode();
  final globalKey = GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  LoginViewModel _loginViewModel;

  @override
  void initState() {
    _loginViewModel = LoginViewModel(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: SafeArea(
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  logoWidget(),
                  _loginForm(),
                  _createAccountWidget(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _createAccountWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: AppLocalizations.of(context).translate('dont_have-account'),
            style: TextStyle(color: lite_blue_color, fontSize: 14),
            children: <TextSpan>[
              TextSpan(
                text: AppLocalizations.of(context).translate('sign_up_now'),
                style: TextStyle(
                    color: lite_blue_color,
                    fontSize: 14,
                    decoration: TextDecoration.underline),
              )
            ]),
      ),
    );
  }

  Widget _loginForm() {
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
                padding: EdgeInsets.only(left: 2, bottom: 4),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Text(
                  AppLocalizations.of(context).translate('login'),
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
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
                    controller: emailTextController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: AppLocalizations.of(context)
                          .translate('email_or_username'),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
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
                    controller: passwordTextController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText:
                      AppLocalizations.of(context).translate('password'),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: new IconButton(
                          icon: new Icon(icon),
                          onPressed: () {
                            hidePassword();
                          }),
                    ),
                    textInputAction: TextInputAction.done,
                    obscureText: isHidePassword,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, bottom: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    child: RichText(
                        text: TextSpan(
                            text: AppLocalizations.of(context)
                                .translate('forgot_password'),
                            style: TextStyle(
                                fontSize: 14, color: lite_blue_color))),
                  ),
                ),
              ),
              PrimaryButton(
                title: 'login',
                onPressed: () =>
                // Navigator.pushReplacementNamed(context, "/homeScreen")
                _loginViewModel.validateLoginFrom(
                    globalKey, emailTextController, passwordTextController),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: RichText(
                        text: TextSpan(
                            text: AppLocalizations.of(context).translate('or'),
                            style: TextStyle(
                                fontSize: 14, color: lite_blue_color))),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _loginViewModel.initiateFacebookLogin();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        LifeWish.facebook_logo,
                        size: 30,
                        color: lite_blue_color,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    width: 1,
                    height: 30,
                    color: lite_blue_color,
                  ),
                  GestureDetector(
                    onTap: () {
                      _loginViewModel.performGoogleLogin(globalKey);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/google_logo.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  hidePassword() {
    isHidePassword = !isHidePassword;
    icon = isHidePassword ? Icons.remove_red_eye : Icons.visibility_off;
    setState(() {});
  }
}
