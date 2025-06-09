import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mservices/utils/app_strings.dart';
import 'package:mservices/utils/constants.dart';
import 'package:mservices/utils/navigation/routes.dart';
import 'package:mservices/utils/palette.dart';
import 'package:mservices/utils/screen_size.dart';
import 'package:mservices/utils/utils.dart';

class MServicesApp extends StatelessWidget {
  const MServicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
        );
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Palette.primary,
              brightness: Brightness.dark,
            ),
            primarySwatch: Palette.generateMaterialColor(),
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
            ),
            useMaterial3: false,
            fontFamily: FontFamily.inter,
            scaffoldBackgroundColor: Palette.white,
          ),
          initialRoute: Routes.splash,
          getPages: Routes.pages,
          builder: (context, child) {
            ScreenSize.init(context);

            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: GestureDetector(
                  onTap: () => Utils.hideKeyboardInApp(context),
                  child: MediaQuery.withNoTextScaling(
                    child: child ?? const SizedBox(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
