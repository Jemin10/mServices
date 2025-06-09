import 'package:get/get.dart';
import 'package:mservices/modules/auth/login/view/login_screen.dart';
import 'package:mservices/modules/auth/provider_form/view/provider_form_screen.dart';
import 'package:mservices/modules/auth/register/view/register_screen.dart';
import 'package:mservices/modules/auth/splash/view/splash_screen.dart';
import 'package:mservices/modules/dashboard/customer/view/customer_dashboard_screen.dart';
import 'package:mservices/modules/dashboard/provider/view/provider_dashboard_screen.dart';
import 'package:mservices/modules/edit_profile/view/edit_profile_screen.dart';
import 'package:mservices/modules/home/view/home_screen.dart';
import 'package:mservices/modules/order/view/order_screen.dart';
import 'package:mservices/modules/profile/view/profile_screen.dart';
import 'package:mservices/modules/provider_details/view/provider_details_screen.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  /// get started
  static const String splash = '/splash-screen';
  static const String register = '/register-screen';
  static const String login = '/login-screen';
  static const String providerForm = '/provider-form-screen';
  static const String customerDashboard = '/customer-dashboard-screen';
  static const String providerDashboard = '/provider-dashboard-screen';
  static const String home = '/home-screen';
  static const String order = '/order-screen';
  static const String providerDetails = '/provider-details-screen';
  static const String profile = '/profile-screen';
  static const String editProfile = '/edit-profile-screen';

  static List<GetPage<dynamic>> pages = [
    GetPage<dynamic>(
      name: splash,
      page: () => SplashScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: register,
      page: () => RegisterScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: login,
      page: () => LoginScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: providerForm,
      page: () => ProviderFormScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: customerDashboard,
      page: () => CustomerDashboardScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: providerDashboard,
      page: () => ProviderDashboardScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: home,
      page: () => HomeScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: order,
      page: () => OrderScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: providerDetails,
      page: () => ProviderDetailsScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: profile,
      page: () => ProfileScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: editProfile,
      page: () => EditProfileScreen(),
      transition: defaultTransition,
    ),
  ];
}
