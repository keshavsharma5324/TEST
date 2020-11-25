import 'package:flutter/material.dart';
import 'package:life_wish/Utils/utilwediget.dart';
import 'package:life_wish/Utils/validator.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/theme/AppColor.dart';
import 'package:life_wish/widgets/PrimaryButton.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditProfileScreenState();
  }
}

class EditProfileScreenState extends State<EditProfileScreen> {
  bool isHideOldPassword = true;
  bool isHideNewPassword = true;
  bool isHideConfPassword = true;
  IconData oldIcon = Icons.remove_red_eye;
  IconData newIcon = Icons.remove_red_eye;
  IconData confIcon = Icons.remove_red_eye;
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
  TextEditingController phoneController = new TextEditingController(text: "");
  TextEditingController oldPasswordController =
      new TextEditingController(text: "");
  TextEditingController newPasswordController =
      new TextEditingController(text: "");

  // FocusNode secondFocusNode = new FocusNode();

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
            title: Text(AppLocalizations.of(context).translate('edit_profile'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 2, bottom: 12, top: 8),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Text(
                AppLocalizations.of(context).translate('edit_profile'),
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
                        borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
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
                        onFieldSubmitted: (String value) {},
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
                        borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
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
                          onFieldSubmitted: (String value) {},
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
                    prefixIcon: Icon(Icons.email),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (String value) {},
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
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: AppLocalizations.of(context)
                        .translate('enter_phone_number'),
                    prefixIcon: Icon(Icons.call),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (String value) {},
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 2, bottom: 12, top: 8),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Text(
                AppLocalizations.of(context).translate('edit_password'),
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
                  controller: oldPasswordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText:
                    AppLocalizations.of(context).translate('old_password'),
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: new IconButton(
                        icon: new Icon(oldIcon),
                        onPressed: () {
                          hideOldPassword();
                        }),
                  ),
                  textInputAction: TextInputAction.done,
                  obscureText: isHideOldPassword,
                  onFieldSubmitted: (String value) {
                    // FocusScope.of(context).requestFocus(secondFocusNode);
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
                  controller: newPasswordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText:
                    AppLocalizations.of(context).translate('new_password'),
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: new IconButton(
                        icon: new Icon(newIcon),
                        onPressed: () {
                          hideNewPassword();
                        }),
                  ),
                  textInputAction: TextInputAction.done,
                  obscureText: isHideNewPassword,
                  onFieldSubmitted: (String value) {
                    //FocusScope.of(context).requestFocus(secondFocusNode);
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
                        icon: new Icon(confIcon),
                        onPressed: () {
                          hideConfPassword();
                        }),
                  ),
                  textInputAction: TextInputAction.done,
                  obscureText: isHideConfPassword,
                  onFieldSubmitted: (String value) {
                    //FocusScope.of(context).requestFocus(secondFocusNode);
                  },
                ),
              ),
            ),
            PrimaryButton(
              title: 'save',
              onPressed: validateSignUpFrom,
            ),
          ],
        ),
      ),
    );
  }

  validateSignUpFrom() {
    if (Validator.validateName(firstNameController.text.trim())) {
      globalKey.currentState.showSnackBar(getSnackBar(
          AppLocalizations.of(context).translate('enter_first_name'),
          AppLocalizations.of(context).translate('ok')));
    } else if (Validator.validateName(lastNameController.text.trim())) {
      globalKey.currentState.showSnackBar(getSnackBar(
          AppLocalizations.of(context).translate('enter_last_name'),
          AppLocalizations.of(context).translate('ok')));
    } else if (Validator.validateEmailId(emailController.text.trim())) {
      globalKey.currentState.showSnackBar(getSnackBar(
          AppLocalizations.of(context).translate('enter_valid_email'),
          AppLocalizations.of(context).translate('ok')));
    } else {
      Navigator.pop(context);
    }
  }

  hideOldPassword() {
    if (isHideOldPassword) {
      isHideOldPassword = false;
      oldIcon = Icons.visibility_off;
    } else {
      isHideOldPassword = true;
      oldIcon = Icons.remove_red_eye;
    }
    setState(() {});
  }

  hideNewPassword() {
    if (isHideNewPassword) {
      isHideNewPassword = false;
      newIcon = Icons.visibility_off;
    } else {
      isHideNewPassword = true;
      newIcon = Icons.remove_red_eye;
    }
    setState(() {});
  }

  hideConfPassword() {
    if (isHideConfPassword) {
      isHideConfPassword = false;
      confIcon = Icons.visibility_off;
    } else {
      isHideConfPassword = true;
      confIcon = Icons.remove_red_eye;
    }
    setState(() {});
  }
}
