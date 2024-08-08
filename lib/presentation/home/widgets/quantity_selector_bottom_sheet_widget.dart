import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/home/items/entity/item_entity.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/common/widgets/quantity_input_dialog.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/common/widgets/toast_utils.dart';

import '../bloc/home_bloc.dart';

class QuantitySelectorBottomSheet extends StatefulWidget {
  final ItemEntity item;
  final ValueChanged<int> onSubmit;

  const QuantitySelectorBottomSheet({
    super.key,
    required this.item,
    required this.onSubmit,
  });

  @override
  State<QuantitySelectorBottomSheet> createState() => _QuantitySelectorBottomSheetState();
}

class _QuantitySelectorBottomSheetState extends State<QuantitySelectorBottomSheet> {
  String _formatCurrency(double price) {
    final format = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return format.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      widget.item.imageUrl,
                      height: 80.h,
                      width: 80.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.item.title,
                                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(32)),
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildQuantitySelector(state),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatCurrency(widget.item.price),
                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.orange),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  widget.onSubmit(state.quantity);
                  Navigator.of(context).pop();
                  context.read<HomeBloc>().add(ResetItemQuantityEvent());
                  ToastUtils.showSuccessToast(message: "Add to Cart Successfully");
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Add to cart',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuantitySelector(HomeState state) {
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              context.read<HomeBloc>().add(DecreaseQuantityEvent());
            },
          ),
          const VerticalDivider(
            width: 1,
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: () => _showQuantityInputDialog(context, widget.item),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                state.quantity.toString(),
                style: TextStyle(fontSize: 16.sp),
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
              context.read<HomeBloc>().add(IncreaseQuantityEvent());
            },
          ),
        ],
      ),
    );
  }

  void _showQuantityInputDialog(BuildContext context, ItemEntity item) {
    final homeBloc = context.read<HomeBloc>();
    final currentQuantity = homeBloc.state.quantity;

    showDialog(
        context: context,
        builder: (context) {
          return QuantityInputDialog(
              item: item,
              initialQuantity: currentQuantity,
              onSubmit: (quantity) {
                homeBloc.add(SetQuantityEvent(quantity: quantity));
              });
        });
  }
}
