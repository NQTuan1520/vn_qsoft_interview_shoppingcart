import 'package:flutter/material.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/cart/ui/cart_screen.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/home/ui/home_screen.dart';

import '../../presentation/splash/ui/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/home':
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    case '/cart':
      return MaterialPageRoute(builder: (context) => const CartScreen());
    default:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
  }
}
