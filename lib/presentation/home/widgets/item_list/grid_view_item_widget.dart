import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/home/items/entity/item_entity.dart';
import '../../../common/animation/fade_animation.dart';

class GridViewItemWidget extends StatelessWidget {
  final BuildContext context;
  final String title;
  final List<ItemEntity> items;
  final Widget Function(ItemEntity item) itemBuilder;

  const GridViewItemWidget(
      {super.key, required this.context, required this.title, required this.items, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      0.3,
      Container(
        padding: EdgeInsets.only(top: 20.h, left: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return itemBuilder(items[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
