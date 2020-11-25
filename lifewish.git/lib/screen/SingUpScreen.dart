import 'package:flutter/material.dart';
import 'package:life_wish/Utils/utilwediget.dart';
import 'package:life_wish/Utils/validator.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/screen/EmailValidationScreen.dart';
import 'package:life_wish/theme/AppColor.dart';
import 'package:life_wish/viewmodels/SignUpViewModel.dart';
import 'package:life_wish/widgets/PrimaryButton.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  bool isHidePassword = true;
  IconData icon = Icons.remove_red_eye;
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = new TextEditingController(text: "");
  TextEditingController passwordController =
      new TextEditingController(text: "");
  TextEditingController confirmPasswordController =
      new TextEditingController(text: "");
  TextEditingController firstNameController =
      new TextEditingController(text: "");
  TextEditingController lastNameController =
      new TextEditingController(text: "");
  FocusNode secondFocusNode = new FocusNode();
  SignUpViewModel _signUpViewModel;

  @override
  void initState() {
    super.initState();
    _signUpViewModel = SignUpViewModel(context: context, globalKey: globalKey);
  }

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
            title: Text(AppLocalizations.of(context).translate('sign_up'),
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
                    height: 0,
                  ),
                  logoWidget(),
                  signUpForm(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  signUpForm() {
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
                  AppLocalizations.of(context).translate('sign_up'),
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.elliptical(4, 4)),
                        ),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          controller: firstNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: AppLocalizations.of(context)
                                .translate('first_name'),
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (String value) {
                            FocusScope.of(context)
                                .requestFocus(secondFocusNode);
                          },
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.elliptical(4, 4)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            controller: lastNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: AppLocalizations.of(context)
                                  .translate('last_name'),
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            onFieldSubmitted: (String value) {
                              FocusScope.of(context)
                                  .requestFocus(secondFocusNode);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                    controller: emailController,
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
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(secondFocusNode);
                    },
                  ),
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
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: AppLocalizations.of(context)
                          .translate('confirm_password'),
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: termOfServiceAndPrivacyWidget(context),
              ),
              PrimaryButton(
                title: 'create_an_account',
                onPressed: () {
                  _signUpViewModel.validateFrom(firstNameController,
                      lastNameController, emailController, passwordController);
                },
              ),
            ],
          ),
        ),
      ),
    );
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
