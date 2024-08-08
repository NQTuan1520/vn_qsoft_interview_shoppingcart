import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/cart/entity/cart_item_entity.dart';
import 'package:vn_qsoft_interview_shoppingcart/managers/routes/route_name.dart';
import '../../home/ui/home_screen.dart';
import '../bloc/cart_bloc.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Text(
                'Cart (${state.items.fold<int>(0, (previousValue, element) => previousValue + element.quantity)})');
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    return CartItemWidget(cartItem: state.items[index]);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.h),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total price', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                        Text(_formatCurrency(_calculateTotalPrice(state.items)),
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () {
                        _showOrderConfirmationDialog(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            'Order',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatCurrency(double price) {
    final format = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return format.format(price);
  }

  double _calculateTotalPrice(List<CartItemEntity> items) {
    return items.fold<double>(0, (previousValue, item) => previousValue + (item.item.price * item.quantity));
  }

  void _showOrderConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Order'),
          content: const Text('Are you sure you want to place this order?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showOrderSuccessDialog(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showOrderSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 80.sp),
              SizedBox(height: 16.h),
              const Text('Order Success'),
            ],
          ),
          content: const Text('Your order has been placed successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<CartBloc>().add(ResetCartItemEvent());
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteName.home,
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Go to Home'),
            ),
          ],
        );
      },
    );
  }
}
