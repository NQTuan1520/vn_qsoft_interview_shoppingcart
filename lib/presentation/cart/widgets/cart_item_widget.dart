import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/cart/entity/cart_item_entity.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/common/animation/fade_animation.dart';

import '../../common/widgets/quantity_input_dialog.dart';
import '../../common/widgets/toast_utils.dart';
import '../bloc/cart_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemEntity cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      0.4,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  cartItem.item.imageUrl,
                  height: 80.h,
                  width: 80.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            cartItem.item.title,
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _showDeleteItemDialog(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildQuantitySelector(context),
                        Text(
                          _formatCurrency(cartItem.item.price),
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              if (cartItem.quantity > 1) {
                BlocProvider.of<CartBloc>(context).add(UpdateItemQuantityEvent(cartItem.item, cartItem.quantity - 1));
              }
            },
          ),
          const VerticalDivider(
            width: 1,
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: () => _showQuantityInputDialog(context),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                cartItem.quantity.toString(),
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
          ),
          const VerticalDivider(
            width: 1,
            color: Colors.grey,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              BlocProvider.of<CartBloc>(context).add(UpdateItemQuantityEvent(cartItem.item, cartItem.quantity + 1));
            },
          ),
        ],
      ),
    );
  }

  void _showQuantityInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return QuantityInputDialog(
          item: cartItem.item,
          initialQuantity: cartItem.quantity,
          onSubmit: (quantity) {
            BlocProvider.of<CartBloc>(context).add(UpdateItemQuantityEvent(cartItem.item, quantity));
          },
        );
      },
    );
  }

  void _showDeleteItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Item"),
          content: const Text("Do you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.deepOrangeAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<CartBloc>(context).add(RemoveItemFromCartEvent(cartItem.item));
                Navigator.pop(context);
                ToastUtils.showSuccessToast(message: "Delete Item Successfully");
              },
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.deepOrangeAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatCurrency(double price) {
    final format = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return format.format(price);
  }
}
