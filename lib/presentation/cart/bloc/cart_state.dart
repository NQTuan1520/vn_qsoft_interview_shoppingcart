part of 'cart_bloc.dart';

class CartState extends Equatable {
  final Status state;
  final List<CartItemEntity> items;

  const CartState({
    this.state = Status.initial,
    this.items = const [],
  });

  CartState copyWith({
    Status? state,
    List<CartItemEntity>? items,
  }) {
    return CartState(
      state: state ?? this.state,
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [state, items];
}
