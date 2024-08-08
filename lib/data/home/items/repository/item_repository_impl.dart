import 'package:vn_qsoft_interview_shoppingcart/data/home/items/models/item_models.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/home/items/repository/item_repository.dart';

import '../../../../generated/assets.dart';

class ItemRepositoryImpl implements ItemRepository {
  final List<ItemModel> _allItems = [
    const ItemModel(id: '1', imageUrl: Assets.imagesProduct0, price: 100000, title: 'Nike Air Max'),
    const ItemModel(id: '2', imageUrl: Assets.imagesProduct1, price: 110000, title: 'Adidas Ultraboost'),
    const ItemModel(id: '3', imageUrl: Assets.imagesProduct2, price: 120000, title: 'Puma RS-X'),
    const ItemModel(id: '4', imageUrl: Assets.imagesProduct3, price: 130000, title: 'Reebok Classic'),
    const ItemModel(id: '5', imageUrl: Assets.imagesProduct4, price: 140000, title: 'New Balance 574'),
    const ItemModel(id: '6', imageUrl: Assets.imagesProduct5, price: 150000, title: 'Asics Gel-Kayano'),
    const ItemModel(id: '7', imageUrl: Assets.imagesProduct6, price: 160000, title: 'Saucony Jazz'),
    const ItemModel(id: '8', imageUrl: Assets.imagesProduct7, price: 170000, title: 'Under Armour HOVR'),
    const ItemModel(id: '9', imageUrl: Assets.imagesProduct8, price: 180000, title: 'Converse Chuck Taylor'),
    const ItemModel(id: '10', imageUrl: Assets.imagesProduct9, price: 190000, title: 'Vans Old Skool'),
    const ItemModel(id: '11', imageUrl: Assets.imagesProduct0, price: 100000, title: 'Nike Air Max'),
    const ItemModel(id: '12', imageUrl: Assets.imagesProduct1, price: 110000, title: 'Adidas Ultraboost'),
    const ItemModel(id: '13', imageUrl: Assets.imagesProduct2, price: 120000, title: 'Puma RS-X'),
    const ItemModel(id: '14', imageUrl: Assets.imagesProduct3, price: 130000, title: 'Reebok Classic'),
    const ItemModel(id: '15', imageUrl: Assets.imagesProduct4, price: 140000, title: 'New Balance 574'),
    const ItemModel(id: '16', imageUrl: Assets.imagesProduct5, price: 150000, title: 'Asics Gel-Kayano'),
    const ItemModel(id: '17', imageUrl: Assets.imagesProduct6, price: 160000, title: 'Saucony Jazz'),
    const ItemModel(id: '18', imageUrl: Assets.imagesProduct7, price: 170000, title: 'Under Armour HOVR'),
    const ItemModel(id: '19', imageUrl: Assets.imagesProduct8, price: 180000, title: 'Converse Chuck Taylor'),
    const ItemModel(id: '20', imageUrl: Assets.imagesProduct9, price: 190000, title: 'Vans Old Skool'),
    const ItemModel(id: '21', imageUrl: Assets.imagesProduct0, price: 100000, title: 'Nike Air Max'),
    const ItemModel(id: '22', imageUrl: Assets.imagesProduct1, price: 110000, title: 'Adidas Ultraboost'),
    const ItemModel(id: '23', imageUrl: Assets.imagesProduct2, price: 120000, title: 'Puma RS-X'),
    const ItemModel(id: '24', imageUrl: Assets.imagesProduct3, price: 130000, title: 'Reebok Classic'),
    const ItemModel(id: '25', imageUrl: Assets.imagesProduct4, price: 140000, title: 'New Balance 574'),
    const ItemModel(id: '26', imageUrl: Assets.imagesProduct5, price: 150000, title: 'Asics Gel-Kayano'),
    const ItemModel(id: '27', imageUrl: Assets.imagesProduct6, price: 160000, title: 'Saucony Jazz'),
    const ItemModel(id: '28', imageUrl: Assets.imagesProduct7, price: 170000, title: 'Under Armour HOVR'),
    const ItemModel(id: '29', imageUrl: Assets.imagesProduct8, price: 180000, title: 'Converse Chuck Taylor'),
    const ItemModel(id: '30', imageUrl: Assets.imagesProduct9, price: 190000, title: 'Vans Old Skool'),
  ];

  @override
  List<ItemModel> getAllItems({int startIndex = 0, int limit = 10}) {
    return _allItems.skip(startIndex).take(limit).toList();
  }
}
