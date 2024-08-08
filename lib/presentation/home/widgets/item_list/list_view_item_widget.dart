import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/home/items/entity/item_entity.dart';

class ListViewItemWidget extends StatelessWidget {
  final BuildContext context;
  final String title;
  final List<ItemEntity> items;
  final Widget Function(ItemEntity item) itemBuilder;

  const ListViewItemWidget(
      {super.key, required this.context, required this.title, required this.items, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h, left: 18.w),
      height: 260.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.local_fire_department,
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return itemBuilder(items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
