import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:life_wish/Model/request/SocialLoginRequest.dart';
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

mixin LoginViewModelMixin {
  onFormValidationFailure();

  onFormValidationSuccess();

  onLoginSuccess();

  onLoginFailure();
}

class LoginViewModel {
  final BuildContext context;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  LoginViewModel(this.context);

  validateLoginFrom(
    globalKey,
    emailTextController,
    passwordTextController,
  ) async {
    final email = emailTextController.text.trim();
    final pwd = passwordTextController.text;
    if (Validator.validateEmailId(email)) {
      _showFeedbackView(globalKey, 'enter_valid_email');
    } else if (Validator.validatePassword(pwd)) {
      _showFeedbackView(globalKey, 'enter_valid_pass');
    } else {
      final SharedPreferences prefs = await _prefs;
      prefs.setBool(CommonUtils.LoginStatus, true).then((bool success) {
        validateUser(LoginRequest(email: email, password: pwd));
        // Navigator.pushReplacementNamed(context, "/homeScreen");
      });
    }
  }

  _showFeedbackView(globalKey, messageKey) {
    globalKey.currentState.showSnackBar(getSnackBar(
        AppLocalizations.of(context).translate(messageKey),
        AppLocalizations.of(context).translate('ok')));
  }

  String onProgressMsg = "Verifying credentials please wait";
  String failedMsg = "Failed to Verifying credentials";
  String successMsg = "Login Successful, preparing your dashboard";

  validateUser(data) async {
    final Future<LoginResponse> res = Api().doLogin(data);
    FeedbackWidget feedbackWidget = FeedbackWidget(
        context: context,
        responseResultFuture: res,
        onProgressMsg: onProgressMsg,
        failedMsg: failedMsg,
        successMsg: successMsg,
        onSuccessCallback: (ApiResponse data) {
          AppRepository().user = data.data.user;
          Navigator.pushReplacementNamed(context, "/homeScreen");
        });
    feedbackWidget.showFeedbackBottomSheet();
  }

  performGoogleLogin(globalKey) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleSignInAccount =
        await googleSignIn.signInSilently();

    if (googleSignInAccount != null) {
      //silent login successful > get the user details
    } else {
      // Prompt user for login
      googleSignInAccount = await googleSignIn.signIn();
    }
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      print(credential.toString());
      final AuthResult authResult =
          await _auth.signInWithCredential(credential);

      final FirebaseUser user = authResult.user;
      final socialRequest = SocialLoginRequest(
          email: user.email,
          firstName: user.displayName,
          lastName: user.displayName,
          providerId: user.uid,
          providerName: 'GOOGLE');
      _handleSocialLoginUserData(socialRequest);
      /*
      print(user.toString());
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final FirebaseUser currentUser = await _auth.currentUser();
      */
    } else {
      //user may canceled the request
      print("error while signing through google");
      globalKey.currentState.showSnackBar(getSnackBar(
          AppLocalizations.of(context).translate('Login failed or canceled.'),
          AppLocalizations.of(context).translate('ok')));
    }
  }

  String onProgressMsg1 = "Processing  your login request";
  String failedMsg1 = "Failed to log you in. Please try again";
  String successMsg1 = "Login Successful, preparing your dashboard";

  _handleSocialLoginUserData(SocialLoginRequest data) async {
    final Future<LoginResponse> res = Api().doSocialLogin(data);
    FeedbackWidget feedbackWidget = FeedbackWidget(
        context: context,
        responseResultFuture: res,
        onProgressMsg: onProgressMsg1,
        failedMsg: failedMsg1,
        successMsg: successMsg1,
        onSuccessCallback: (ApiResponse data) {
          AppRepository().user = data.data.user;
          Navigator.pushReplacementNamed(context, "/homeScreen");
        });
    feedbackWidget.showFeedbackBottomSheet();
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.loggedIn:
        //FacebookResponse response = await Api.getApiClient().getEmailFromFacebook(facebookLoginResult.accessToken.token);
        _getFacebookUserDetails(facebookLoginResult.accessToken.token);
        //socialLoginApiCalling(response.email, response.firstName, response.lastName ,"", true);
        break;
    }
  }

  _getFacebookUserDetails(token) async {
    final String res = await Api().getFacebookUserDetail(token);
    print('_getFacebookUserDetails $res');
    final user = json.decode(res);
    final socialRequest = SocialLoginRequest(
        email: user.email,
        firstName: user.first_name,
        lastName: user.last_name,
        providerId: user.id,
        providerName: 'FACEBOOK');
    _handleSocialLoginUserData(socialRequest);
  }
}
