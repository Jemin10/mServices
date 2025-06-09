import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mservices/utils/app_strings.dart';

abstract class FontFamily {
  static const String squada = "Squada";
  static const String inter = "Inter";
}

abstract class PrefKey {
  static const String isLogin = 'is-login';
  static const String userType = 'user-type';
  static const String user = 'user';
}

abstract class FirebaseCollections {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static CollectionReference users = db.collection('users');
  static CollectionReference products = db.collection('products');
}

abstract class FirebaseAuthErrors {
  static String getErrorMessage(String e) {
    switch (e) {
      case 'network-request-failed':
        return AuthErrors.noInternetError;
      case 'too-many-requests':
        return AuthErrors.attemptsError;
      case 'weak-password':
        return AuthErrors.weakPassError;
      case 'email-already-in-use':
        return AuthErrors.emailInUseError;
      case 'invalid-email':
        return AuthErrors.invalidEmailError;
      case 'provider-already-linked':
        return AuthErrors.alreadyLinkedError;
      case 'invalid-credential':
        return AuthErrors.invalidCredentialsError;
      case 'credential-already-in-use':
        return AuthErrors.credInUseError;
      case 'user-not-found':
        return AuthErrors.userNotFoundError;
      case 'wrong-password':
        return AuthErrors.wrongPassError;
      case 'user-disabled':
        return AuthErrors.userDisabledError;
      case 'account-exists-with-different-credential':
        return AuthErrors.accountExistsError;
      default:
        return AuthErrors.commonErrorMsg;
    }
  }
}
