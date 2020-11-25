import 'package:email_validator/email_validator.dart';

class Validator {

  //static Pattern emailPattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
 // static RegExp regexEmail = new RegExp(emailPattern);
  static const int NORMAL_VALIDATION = 1;
  static const int EMAIL_VALIDATION = 2;
  static const int PHONE_VALIDATION = 3;
  static const int STRONG_PASSWORD_VALIDATION = 4;
  static const int PHONE_OR_EMAIL_VALIDATION = 5;

  static Pattern phonePattern = "\\d{10}|(?:\\d{3}-){2}\\d{4}|\\(\\d{3}\\)\\d{3}-?\\d{4}";
  static RegExp regexPhone = new RegExp(phonePattern);

  static bool validateEmailId(String value){
      if(value.isEmpty){
        return true;
      }else{
        if (EmailValidator.validate(value)) {
          return false;
        } else {
          return true;
        }
      }
  }

  static bool validateName(String value){
    if(value.isEmpty){
      return true;
    }else{
      return false;
    }
  }

  static bool validatePassword(String value){

    if (value.isNotEmpty) {
      if (value.length >= 1) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }

  }


  static bool validateOTP(String value){

    if (value.isNotEmpty) {
      if (value.length == 6) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }

  }

  static bool validateMobileNo(String value){
    if(value.isEmpty){
      return true;
    }else{
      if (regexPhone.hasMatch(value)) {
        return false;
      } else {
        return true;
      }
    }
  }

  static validateEmail(String value, String errorTextForEmptyField,
      String errorTextForInvalidField) {
    if (value.isNotEmpty) {
      if (EmailValidator.validate(value)) {
        return null;
      } else {
        return errorTextForInvalidField;
      }
    } else {
      return errorTextForEmptyField;
    }
  }

  static validateFormField(String value, String errorTextForEmptyField,
      String errorTextInvalidField, int type) {
    switch (type) {
      case NORMAL_VALIDATION:
        if (value.isEmpty) {
          return errorTextForEmptyField;
        }
        break;

      case EMAIL_VALIDATION:
        return validateEmail(value, errorTextForEmptyField, errorTextInvalidField);
        break;

      case PHONE_VALIDATION:
        if (value.isNotEmpty) {
          if (isNumeric(value) && value.length == 10) {
            return null;
          } else {
            return errorTextInvalidField;
          }
        } else {
          return errorTextForEmptyField;
        }
        break;

      case STRONG_PASSWORD_VALIDATION:
        if (value.isNotEmpty) {
          if (value.length >= 6) {
            return null;
          } else {
            return errorTextInvalidField;
          }
        } else {
          return errorTextForEmptyField;
        }
        break;

      case PHONE_OR_EMAIL_VALIDATION:
        if (value.isNotEmpty) {
          if (EmailValidator.validate(value)) {
            return null;
          } else if (isNumeric(value)) {
            if(value.length == 10){
              return null;
            }else{
              return errorTextInvalidField;
            }
          } else {
            return errorTextInvalidField;
          }
        } else {
          return errorTextForEmptyField;
        }
        break;
    }
  }

  static bool isNumeric(String str) {
    try{
      var value = double.parse(str);
    } on FormatException {
      return false;
    } finally {
      return true;
    }
  }

  static bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

}
