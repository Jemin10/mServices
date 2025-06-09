import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  /// EMAIL INPUT FORMATTER
  static List<TextInputFormatter> emailInputFormatter() => [
        FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9._@]')),
      ];

  /// HIDE KEYBOARD
  static void hideKeyboardInApp(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  /// LAUNCH DIALER
  static Future<void> launchDialer(String mobileNumber) async {
    final Uri dialerUri = Uri(scheme: 'tel', path: mobileNumber);

    if (await canLaunchUrl(dialerUri)) {
      await launchUrl(dialerUri);
    } else {
      throw 'Could not launch dialer for $mobileNumber';
    }
  }
}
