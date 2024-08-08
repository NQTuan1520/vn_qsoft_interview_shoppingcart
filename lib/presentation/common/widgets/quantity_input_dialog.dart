import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/home/items/entity/item_entity.dart';

class QuantityInputDialog extends StatefulWidget {
  final ItemEntity item;
  final int initialQuantity;
  final ValueChanged<int> onSubmit;

  const QuantityInputDialog({
    super.key,
    required this.item,
    required this.initialQuantity,
    required this.onSubmit,
  });

  @override
  State<QuantityInputDialog> createState() => _QuantityInputDialogState();
}

class _QuantityInputDialogState extends State<QuantityInputDialog> {
  late TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuantity.toString());
    _controller.addListener(_validate);
  }

  void _validate() {
    setState(() {
      int? value = int.tryParse(_controller.text);
      if (value == null || value < 1) {
        _errorText = 'Quantity must be > 0';
      } else if (value > 999) {
        _errorText = 'Quantity must be ≤ 999';
      } else {
        _errorText = null;
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_validate);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          widget.item.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          errorText: _errorText,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: _errorText == null
              ? () {
                  widget.onSubmit(int.parse(_controller.text));
                  Navigator.of(context).pop();
                }
              : null,
          child: Container(
            height: 40.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
