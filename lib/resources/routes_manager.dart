import 'package:flutter/material.dart';

import '../onBoarding/onBoarding_Page.dart';
import '../resources/strings_manager.dart';
import '../screen/dashboard.dart';
import '../screen/home_page.dart';

class Routes {
  static const String homePage = "/";
  static const String onboarding = "onboarding";
  static const String dashboard = "dashboard";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) => const Dashboard());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('noRouteFound'),
              ),
              body: const Center(
                  child: Text('noRouteFound, press the back button')),
            ));
  }
}
