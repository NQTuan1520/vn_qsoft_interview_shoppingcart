import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/home/items/entity/item_entity.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/home/widgets/item_list/grid_view_item_widget.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/home/widgets/item_list/list_view_item_widget.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/home/widgets/quantity_selector_bottom_sheet_widget.dart';

import '../../common/animation/fade_animation.dart';

class ItemListWidget extends StatelessWidget {
  final List<ItemEntity> items;
  final ValueChanged<Map<ItemEntity, int>> onAddToCart;

  const ItemListWidget({
    super.key,
    required this.items,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListViewItemWidget(
          context: context,
          title: "HOT Products",
          items: items,
          itemBuilder: (item) => _buildProductCard(context, item, 'hot', true),
        ),
        GridViewItemWidget(
          context: context,
          title: "All Products",
          items: items,
          itemBuilder: (item) => _buildProductCard(context, item, 'all', false),
        )
      ],
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    ItemEntity item,
    String section,
    bool showFireIcon,
  ) {
    return FadeAnimation(
      0.3,
      Container(
        height: 310.h,
        width: 140.w,
        margin: EdgeInsets.only(right: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(width: 1.5, color: Colors.grey.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: Stack(
                children: [
                  Image.asset(
                    item.imageUrl,
                    height: 100.h,
                    width: 190.w,
                    fit: BoxFit.cover,
                  ),
                  showFireIcon
                      ? Positioned(
                          top: 8.h,
                          left: 8.w,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.local_fire_department,
                              color: Colors.deepOrange,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w, bottom: 8.h),
                  child: Text(
                    _formatCurrency(item.price),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                FloatingActionButton(
                  heroTag: '${section}_${item.id}_add_to_cart',
                  backgroundColor: Colors.deepOrange,
                  onPressed: () {
                    _showQuantitySelector(context, item);
                  },
                  mini: true,
                  // backgroundColor: colorTheme.blueBottomBar,
                  child: Icon(Icons.add_shopping_cart, color: Colors.white, size: 20.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showQuantitySelector(BuildContext context, ItemEntity item) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return QuantitySelectorBottomSheet(
            item: item,
            onSubmit: (quantity) {
              onAddToCart({item: quantity});
            },
          );
        });
  }

  String _formatCurrency(double price) {
    final format = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return format.format(price);
  }
}
