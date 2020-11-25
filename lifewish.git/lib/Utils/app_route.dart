import 'dart:io';
import 'package:flutter/material.dart';
import 'package:life_wish/screen/LifeWishDetailScreen.dart';
import 'package:life_wish/screen/MediaControl/CameraScreen.dart';
import 'package:life_wish/screen/ChangePasswordScreen.dart';
import 'package:life_wish/screen/EditProfileScreen.dart';
import 'package:life_wish/screen/EmailValidationScreen.dart';
import 'package:life_wish/screen/ForgotPasswordScreen.dart';
import 'package:life_wish/screen/LicenceScreen.dart';
import 'package:life_wish/screen/NotificationScreen.dart';
import 'package:life_wish/screen/PhoneNumberScreen.dart';
import 'package:life_wish/screen/HomeScreen.dart';
import 'package:life_wish/screen/LanguageScreen.dart';
import 'package:life_wish/screen/LoginScreen.dart';
import 'package:life_wish/screen/MyLifeWish.dart';
import 'package:life_wish/screen/NewLifeWishesScreen.dart';
import 'package:life_wish/screen/PhoneOtpScreen.dart';
import 'package:life_wish/screen/ReceiveLifeWish.dart';
import 'package:life_wish/screen/SingUpScreen.dart';
import 'package:life_wish/screen/SplashScreen.dart';

Map<String, WidgetBuilder> getAppRoute() {
  return {
    '/': (BuildContext context) => SplashScreen(),
    "/loginScreen": (BuildContext context) => LoginScreen(),
    "/signUpScreen": (BuildContext context) => SignUpScreen(),
    "/homeScreen": (BuildContext context) => HomeScreen(),
    "/myLifeWish": (BuildContext context) => MyLifeWish(),
    "/newLifeWishesScreen": (BuildContext context) => NewLifeWishesScreen(),
    "/receiveLifeWish": (BuildContext context) => ReceiveLifeWish(),
    "/phoneOtpScreen": (BuildContext context) => PhoneOtpScreen(),
    "/PhoneNumberScreen": (BuildContext context) => PhoneNumberScreen(),
    "/changePasswordScreen": (BuildContext context) => ChangePasswordScreen(),
    "/languageScreen": (BuildContext context) => LanguageScreen(),
    "/emailValidationScreen": (BuildContext context) => EmailValidationScreen(),
    "/licenceScreen": (BuildContext context) => LicenceScreen(),
    "/forgotPasswordScreen": (BuildContext context) => ForgotPasswordScreen(),
    "/notificationScreen": (BuildContext context) => NotificationScreen(),
    "/editProfileScreen": (BuildContext context) => EditProfileScreen(),
    "/cameraDemoScreen": (BuildContext context) => CameraScreen(),
    "/lifeWishDetailScreen": (BuildContext context) => LifeWishDetailScreen(),
  };
}
