import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/cart/entity/cart_item_entity.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/home/items/entity/item_entity.dart';

import '../../../managers/local_storage/database_helpers.dart';
import '../../../managers/utils/enum.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final DatabaseHelper databaseHelper;

  CartBloc({required this.databaseHelper}) : super(const CartState()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddItemToCartEvent>(_onAddItemToCart);
    on<RemoveItemFromCartEvent>(_onRemoveItemFromCart);
    on<UpdateItemQuantityEvent>(_onUpdateItemQuantity);
    on<ResetCartItemEvent>(_onResetCartItem);
  }

  void _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    final items = await databaseHelper.getCartItems();
    emit(state.copyWith(items: items));
  }

  void _onAddItemToCart(AddItemToCartEvent event, Emitter<CartState> emit) async {
    final existingItem = state.items.firstWhere(
      (item) => item.item.id == event.item.id,
      orElse: () => CartItemEntity(item: event.item, quantity: 0),
    );

    final updatedItems = [
      ...state.items.where((item) => item.item.id != event.item.id),
      CartItemEntity(item: event.item, quantity: existingItem.quantity + event.quantity),
    ];

    await databaseHelper
        .insertCartItem(CartItemEntity(item: event.item, quantity: existingItem.quantity + event.quantity));
    emit(state.copyWith(items: updatedItems));
  }

  void _onRemoveItemFromCart(RemoveItemFromCartEvent event, Emitter<CartState> emit) async {
    final updatedItems = state.items.where((item) => item.item.id != event.item.id).toList();
    await databaseHelper.removeCartItem(event.item.id);
    emit(state.copyWith(items: updatedItems));
  }

  void _onResetCartItem(ResetCartItemEvent event, Emitter<CartState> emit) async {
    await databaseHelper.clearCart();
    emit(state.copyWith(items: []));
  }

  void _onUpdateItemQuantity(UpdateItemQuantityEvent event, Emitter emit) {
    final updatedItems = List<CartItemEntity>.from(state.items);
    final itemIndex = updatedItems.indexWhere((item) => item.item.id == event.item.id);
    if (itemIndex != -1) {
      updatedItems[itemIndex] = CartItemEntity(item: event.item, quantity: event.quantity);
    }
    emit(state.copyWith(items: updatedItems));
  }

  int getTotalQuantity() {
    return state.items.fold<int>(0, (total, item) => total + item.quantity);
  }
}
