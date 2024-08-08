import 'package:flutter/material.dart';
import 'package:vn_qsoft_interview_shoppingcart/managers/routes/route_name.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/cart/ui/cart_screen.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/home/ui/home_screen.dart';

import '../../presentation/splash/ui/splash_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RouteName.cart:
        return MaterialPageRoute(builder: (context) => const CartScreen());
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
