import 'package:real_estate_app/features/auth/presentation/view/login_view.dart';
import 'package:real_estate_app/features/auth/presentation/view/register_view.dart';
import 'package:real_estate_app/features/home/presentation/view/bottom_view/add_property_view.dart';

import '../../features/home/presentation/view/dashboard_view.dart';
import '../../features/splash/presentation/view/splash_view.dart';

class AppRoute {
  AppRoute._();
  static const String splashRoute = '/splash';

  static const String dashboardRoute = '/dashboardRoute';
  static const String loginRoute = '/loginRoute';
  static const String registerRoute = '/registerRoute';
  static const String addPropertyRoute = '/addPropertyRoute';

  static getAppRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      dashboardRoute: (context) => const DashboardView(),
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      addPropertyRoute: (context) => const AddPropertyPage(),
    };
  }
}
