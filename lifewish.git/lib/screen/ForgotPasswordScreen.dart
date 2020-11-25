import 'package:flutter/material.dart';
import 'package:life_wish/Utils/utilwediget.dart';
import 'package:life_wish/Utils/validator.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/screen/EmailValidationScreen.dart';
import 'package:life_wish/theme/AppColor.dart';
import 'package:life_wish/widgets/PrimaryButton.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordScreenState();
  }
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = new TextEditingController(text: "");
  final globalKey = GlobalKey<ScaffoldState>();

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
            title: Text(
                AppLocalizations.of(context).translate('forgot_password'),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            centerTitle: true,
            backgroundColor: transparent_color,
          ),
        ),
        key: globalKey,
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Theme(
                  data: ThemeData(primaryColor: primaryColor),
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: 2,
                            bottom: 4,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('enter_registered_email'),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 4, top: 10),
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
                              controller: emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: AppLocalizations.of(context)
                                    .translate('enter_registered_email'),
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                        PrimaryButton(
                          title: 'submit',
                          onPressed: () {
                            if (Validator.validateEmailId(
                                emailController.text.trim())) {
                              globalKey.currentState.showSnackBar(getSnackBar(
                                  AppLocalizations.of(context)
                                      .translate('enter_valid_email'),
                                  AppLocalizations.of(context)
                                      .translate('ok')));
                            } else {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EmailValidationScreen()),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )),
          );
        }),
      ),
    );
  }
}
