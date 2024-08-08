import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vn_qsoft_interview_shoppingcart/domain/cart/entity/cart_item_entity.dart';
import 'package:vn_qsoft_interview_shoppingcart/data/home/items/models/item_models.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cart_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart_items (
        id TEXT PRIMARY KEY,
        imageUrl TEXT,
        title TEXT,
        price REAL,
        quantity INTEGER
      )
    ''');
  }

  Future<void> insertCartItem(CartItemEntity cartItem) async {
    final db = await database;
    await db.insert(
      'cart_items',
      cartItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeCartItem(String id) async {
    final db = await database;
    await db.delete(
      'cart_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart_items');
  }

  Future<List<CartItemEntity>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart_items');

    return List.generate(maps.length, (i) {
      return CartItemEntity(
        item: ItemModel(
          id: maps[i]['id'],
          imageUrl: maps[i]['imageUrl'],
          title: maps[i]['title'],
          price: maps[i]['price'],
        ),
        quantity: maps[i]['quantity'],
      );
    });
  }
}
