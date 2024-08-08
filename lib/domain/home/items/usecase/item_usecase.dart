import 'package:vn_qsoft_interview_shoppingcart/domain/home/items/entity/item_entity.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/home/items/repository/item_repository.dart';

class ItemUseCase {
  final ItemRepository itemRepository;

  ItemUseCase(this.itemRepository);

  List<ItemEntity> getItems({int startIndex = 0, int limit = 10}) {
    return itemRepository.getAllItems(startIndex: startIndex, limit: limit);
  }
}
