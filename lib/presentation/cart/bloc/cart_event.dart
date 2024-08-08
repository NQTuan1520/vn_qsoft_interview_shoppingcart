part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class AddItemToCartEvent extends CartEvent {
  final ItemEntity item;
  final int quantity;

  const AddItemToCartEvent(this.quantity, {required this.item});

  @override
  List<Object?> get props => [item, quantity];
}

class RemoveItemFromCartEvent extends CartEvent {
  final ItemEntity item;

  const RemoveItemFromCartEvent(this.item);

  @override
  List<Object?> get props => [item];
}

class UpdateItemQuantityEvent extends CartEvent {
  final ItemEntity item;
  final int quantity;

  const UpdateItemQuantityEvent(this.item, this.quantity);

  @override
  List<Object?> get props => [item, quantity];
}

class ResetCartItemEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class LoadCartEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}
