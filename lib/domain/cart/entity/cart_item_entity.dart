import 'package:equatable/equatable.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/home/items/entity/item_entity.dart';

class CartItemEntity extends Equatable {
  final ItemEntity item;
  final int quantity;

  const CartItemEntity({required this.item, required this.quantity});

  @override
  List<Object?> get props => [item, quantity];

  Map<String, dynamic> toMap() {
    return {
      'id': item.id,
      'imageUrl': item.imageUrl,
      'title': item.title,
      'price': item.price,
      'quantity': quantity,
    };
  }
}
