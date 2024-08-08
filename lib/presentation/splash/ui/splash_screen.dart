import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vn_qsoft_interview_shoppingcart/managers/routes/route_name.dart';

import '../../../generated/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(RouteName.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                height: 100.h,
                width: 100.h,
                Assets.imagesCart,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.h),
            child: Text(
              "@ 2024, QSoft. All rights reserved",
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
