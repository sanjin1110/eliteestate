import 'package:flutter/material.dart';

import '../config/routes/app_route.dart';
import '../config/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.splashRoute,
      theme: AppTheme.getApplicationTheme(),
      routes: AppRoute.getAppRoute(),
    );
  }
}
