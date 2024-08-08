import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vn_qsoft_interview_shoppingcart/managers/local_storage/database_helpers.dart';
import 'package:vn_qsoft_interview_shoppingcart/managers/service_locator/di.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/cart/bloc/cart_bloc.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/home/bloc/home_bloc.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/splash/ui/splash_screen.dart';

import 'managers/routes/app_routes.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CartBloc>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shopping Cart',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          onGenerateRoute: generateRoute,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
