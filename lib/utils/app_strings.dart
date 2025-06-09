class AppStrings {
  static const String appName = "mServices";
  static const String appPackageName = "com.mservices.app.mservices";
}

abstract class AuthErrors {
  static const String noInternetError = "No Internet Connection";
  static const String attemptsError = "Too many attempts please try again later";
  static const String weakPassError = "Provided password is too weak";
  static const String emailInUseError = "Account already exists with your email";
  static const String invalidEmailError = "Email is not valid";
  static const String alreadyLinkedError = "Provider has already been linked to the user";
  static const String invalidCredentialsError = "Provider's credentials is not valid";
  static const String credInUseError =
      "The account corresponding to the credential already exists,or is already linked to a Firebase User";
  static const String userNotFoundError = "No user found for that email";
  static const String wrongPassError = "The password is invalid for the given email";
  static const String userDisabledError = "The user corresponding to the given email has been disabled";
  static const String accountExistsError = "Account already exists with different credentials";
  static const String commonErrorMsg = "Something went wrong";
  static const String plsEnterEmail = "Please enter your email address.";
  static const String plsEnterValidEmail = "Please enter a valid email address.";
  static const String plsEnterPass = "Please enter your password.";
  static const String passLengthError = "Password must be at least 6 characters long.";
  static const String passFormatError =
      "Password must contain at least one uppercase letter, one number, and one special character.";
  static const String plsEnterConfirmPass = "Please enter your confirm password.";
  static const String passAndConfirmPassSameError = "Password and Confirm password should be same.";
  static const String plsEnterName = "Please enter your name.";
}
