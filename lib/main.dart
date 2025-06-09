import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mservices/firebase_options.dart';
import 'package:mservices/mservices_app.dart';
import 'package:mservices/utils/app_preference.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await ScreenUtil.ensureScreenSize();
    await AppPreference.initMySharedPreferences();

    runApp(const MServicesApp());
  }, (error, stack) {
    if (kDebugMode) {
      log("error==========>>>>>>>>>\n$error");
      log("stack==========>>>>>>>>>\n$stack");
    }
  });
}
