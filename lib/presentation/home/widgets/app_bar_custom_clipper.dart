import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;
import 'package:vn_qsoft_interview_shoppingcart/presentation/cart/bloc/cart_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool showAssetImage;
  final bool showMenuItem;
  final VoidCallback? onShoppingPressed;

  const CustomAppBar({
    super.key,
    required this.height,
    this.showAssetImage = true,
    this.showMenuItem = true,
    this.onShoppingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Stack(
          children: [
            Positioned(
              top: 10.h,
              child: ClipPath(
                clipper: AppBarCustomClipper(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: height,
                  color: Colors.orange.shade100,
                ),
              ),
            ),
            // Top Layer
            ClipPath(
              clipper: AppBarCustomClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFF8B61B),
                      Color(0xFFFC8607),
                      Color(0xFFFD8004),
                      Color(0xFFFE7A02),
                      Color(0xFFFF7500),
                    ],
                  ),
                ),
              ),
            ),
            showMenuItem
                ? Positioned(
                    top: 40.h,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Center(
                          child: Text(
                            "Home",
                            style: TextStyle(color: Colors.white, fontSize: 25.sp),
                          ),
                        ),
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            final totalQuantity = context.read<CartBloc>().getTotalQuantity();
                            return Row(
                              children: [
                                badges.Badge(
                                  position: badges.BadgePosition.topEnd(top: -10, end: 4),
                                  badgeContent: Text(
                                    totalQuantity.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                    ),
                                    onPressed: onShoppingPressed,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height - 50.h);
}

class AppBarCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    var path = Path();
    path.lineTo(0, height - 50.h);
    path.quadraticBezierTo(width / 2.w, height, width, height - 50.h);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
