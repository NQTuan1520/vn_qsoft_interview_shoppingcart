part of 'home_bloc.dart';

class HomeState extends Equatable {
  final Status status;
  final List<ItemEntity> itemEntity;
  final bool hasMoreItems;
  final int quantity;

  const HomeState({
    this.status = Status.initial,
    this.itemEntity = const [],
    this.hasMoreItems = true,
    this.quantity = 1,
  });

  HomeState copyWith({
    Status? status,
    List<ItemEntity>? itemEntity,
    bool? hasMoreItems,
    int? quantity,
  }) {
    return HomeState(
      status: status ?? this.status,
      itemEntity: itemEntity ?? this.itemEntity,
      hasMoreItems: hasMoreItems ?? this.hasMoreItems,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [status, itemEntity, hasMoreItems, quantity];
}
