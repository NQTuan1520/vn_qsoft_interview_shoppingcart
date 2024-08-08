import 'package:get_it/get_it.dart';
import 'package:vn_qsoft_interview_shoppingcart/data/home/items/repository/item_repository_impl.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/home/items/repository/item_repository.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/home/items/usecase/item_usecase.dart';
import 'package:vn_qsoft_interview_shoppingcart/managers/local_storage/database_helpers.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/cart/bloc/cart_bloc.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/home/bloc/home_bloc.dart';

final sl = GetIt.instance;

void init() {
  sl.registerSingleton<DatabaseHelper>(DatabaseHelper());
  sl.registerLazySingleton<ItemRepository>(() => ItemRepositoryImpl());

  sl.registerLazySingleton(() => ItemUseCase(sl<ItemRepository>()));

  sl.registerFactory(() => HomeBloc(itemUseCase: sl<ItemUseCase>()));

  sl.registerFactory(() => CartBloc(databaseHelper: sl<DatabaseHelper>()));
}
