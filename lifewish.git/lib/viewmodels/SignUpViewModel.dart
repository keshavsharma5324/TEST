import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:life_wish/Model/request/SocialLoginRequest.dart';
import 'package:life_wish/screen/EmailValidationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/response/LoginResponse.dart';
import '../repository/AppRepository.dart';
import '../widgets/FeedbackWidget.dart';

import '../Model/request/LoginRequest.dart';
import '../Utils/CommonUtils.dart';
import '../Utils/utilwediget.dart';
import '../Utils/validator.dart';
import '../lang/app_localizations.dart';

import '../api/api.dart';

class SignUpViewModel {
  final BuildContext context;
  final GlobalKey<ScaffoldState> globalKey;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SignUpViewModel({@required this.context, @required this.globalKey})
      : assert(context != null && globalKey != null);

  validateFrom(firstNameController, lastNameController, emailController,
      passwordController) {
    if (Validator.validateName(firstNameController.text.trim())) {
      _showFeedbackView('enter_first_name');
    } else if (Validator.validateName(lastNameController.text.trim())) {
      _showFeedbackView('enter_last_name');
    } else if (Validator.validateEmailId(emailController.text.trim())) {
      _showFeedbackView('enter_valid_email');
    } else if (Validator.validatePassword(passwordController.text)) {
      _showFeedbackView('enter_valid_pass');
    } else if (Validator.validatePassword(passwordController.text)) {
      _showFeedbackView('enter_valid_pass');
    } else {
      final data = SocialLoginRequest(
          email: emailController.text.trim(),
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          password: passwordController.text,
          providerName: 'EMAIL');
      _createUser(data);
    }
  }

  _showFeedbackView(messageKey) {
    globalKey.currentState.showSnackBar(getSnackBar(
        AppLocalizations.of(context).translate(messageKey),
        AppLocalizations.of(context).translate('ok')));
  }

  String onProgressMsg = "Creating your LifeWish account";
  String failedMsg = "Failed to create account. Please try again.";
  String successMsg = "Account created successfully";

  _createUser(data) async {
    final Future<LoginResponse> res = Api().userRegistration(data);
    FeedbackWidget feedbackWidget = FeedbackWidget(
        context: context,
        responseResultFuture: res,
        onProgressMsg: onProgressMsg,
        failedMsg: failedMsg,
        successMsg: successMsg,
        onSuccessCallback: (ApiResponse data) {
          AppRepository().user = data.data.user;

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EmailValidationScreen(from: "signup")),
          );
        });
    feedbackWidget.showFeedbackBottomSheet();
  }
}
