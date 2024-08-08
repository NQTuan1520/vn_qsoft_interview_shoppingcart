import 'package:vn_qsoft_interview_shoppingcart/domain/home/items/entity/item_entity.dart';

class ItemModel extends ItemEntity {
  const ItemModel({
    required super.id,
    required super.imageUrl,
    required super.price,
    required super.title,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'price': price,
    };
  }
}
