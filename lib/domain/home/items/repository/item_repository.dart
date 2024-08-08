import 'package:vn_qsoft_interview_shoppingcart/domain/home/items/entity/item_entity.dart';

abstract class ItemRepository {
  List<ItemEntity> getAllItems({int startIndex, int limit});
}
