import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/home/items/entity/item_entity.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/home/items/usecase/item_usecase.dart';
import 'package:vn_qsoft_interview_shoppingcart/managers/utils/enum.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ItemUseCase itemUseCase;

  HomeBloc({required this.itemUseCase}) : super(const HomeState()) {
    on<LoadItemsEvent>(_onLoadItems);
    on<LoadMoreItemsEvent>(_onLoadMoreItems);
    on<RefreshItemsEvent>(_onRefreshItems);
    on<IncreaseQuantityEvent>(_onIncreaseQuantity);
    on<DecreaseQuantityEvent>(_onDecreaseQuantity);
    on<SetQuantityEvent>(_onSetQuantity);
    on<ResetItemQuantityEvent>(_onResetItemQuantity);
  }

  void _onLoadItems(LoadItemsEvent event, Emitter emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      final items = itemUseCase.getItems();
      emit(state.copyWith(status: Status.success, itemEntity: items, hasMoreItems: items.length == 10));
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  void _onLoadMoreItems(LoadMoreItemsEvent event, Emitter emit) {
    if (!state.hasMoreItems) return;

    try {
      final items = itemUseCase.getItems(startIndex: state.itemEntity.length);
      if (items.isNotEmpty) {
        emit(state.copyWith(
          status: Status.success,
          itemEntity: List.of(state.itemEntity)..addAll(items),
          hasMoreItems: items.length == 10,
        ));
      } else {
        emit(state.copyWith(hasMoreItems: false));
      }
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  void _onRefreshItems(RefreshItemsEvent event, Emitter emit) {
    emit(state.copyWith(status: Status.loading));
    try {
      final items = itemUseCase.getItems();
      emit(state.copyWith(status: Status.success, itemEntity: items, hasMoreItems: items.length == 10));
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  void _onIncreaseQuantity(IncreaseQuantityEvent event, Emitter emit) {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void _onDecreaseQuantity(DecreaseQuantityEvent event, Emitter emit) {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  void _onSetQuantity(SetQuantityEvent event, Emitter emit) {
    emit(state.copyWith(quantity: event.quantity));
  }

  void _onResetItemQuantity(ResetItemQuantityEvent event, Emitter emit) {
    emit(state.copyWith(quantity: 1));
  }
}
