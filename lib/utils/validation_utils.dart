import 'package:get/get.dart';

class AppValidation {
  static String? emptyValidator(String? value, String errorMessage) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static String? nullValidator<T>(T? value, String errorMessage) {
    if (value == null) {
      return errorMessage;
    }
    return null;
  }

  static String? emailValidator(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);

    if (value == null || value.trim().isEmpty) {
      return "Please enter Email";
    } else if (!regex.hasMatch(value)) {
      return "Please enter a valid Email";
    }

    return null;
  }

  static String? passValidator(String? value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);

    if (value == null || value.trim().isEmpty) {
      return "Please enter Password";
    } else if (value.trim().length < 6) {
      return "Password must be at least 6 characters long";
    } else if (!regex.hasMatch(value)) {
      return "Password must contain at least one uppercase letter, one number, and one special character";
    }
    return null;
  }

  static String? mobileNumberValidator(String? value) {
    if (value?.trim().length != 10) {
      return "Please enter a valid mobile number";
    }
    return null;
  }

  static String? rateValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your Hourly Rate for service";
    } else if (value.trim() == "0") {
      return "Hourly Rate can't be 0₹";
    } else if (int.parse(value.trim()).isGreaterThan(1000)) {
      return "Hourly Rate can't be more than 1000₹";
    }
    return null;
  }
}
