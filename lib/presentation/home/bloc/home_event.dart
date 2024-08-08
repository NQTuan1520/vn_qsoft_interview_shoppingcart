part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadItemsEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class LoadMoreItemsEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class RefreshItemsEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class IncreaseQuantityEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class DecreaseQuantityEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class SetQuantityEvent extends HomeEvent {
  final int quantity;

  const SetQuantityEvent({required this.quantity});

  @override
  List<Object> get props => [quantity];
}

class ResetItemQuantityEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}
