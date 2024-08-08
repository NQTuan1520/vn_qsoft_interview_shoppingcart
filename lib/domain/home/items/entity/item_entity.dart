import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String id;
  final String imageUrl;
  final String title;
  final double price;

  const ItemEntity({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  List<Object?> get props => [id, imageUrl, title, price];
}
