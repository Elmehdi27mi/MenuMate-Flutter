import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tp_plat1/models/produc_model.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init();
  static Database? _database;

  ProductDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('products.db');
    return _database!;
  }

  Future<void> insertItemsList(List<ShoppingCartItem> itemsList) async {
    final db = await instance.database;
    final batch = db.batch();
    itemsList.forEach((item) {
      batch.insert('products', item.toMap());
    });
    await batch.commit();
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE products(
      productId INTEGER PRIMARY KEY AUTOINCREMENT,
      productName TEXT NOT NULL,
      productDescription TEXT NOT NULL,
      productImage TEXT NOT NULL,
      unitPrice REAL NOT NULL,
      quantity INTEGER NOT NULL,
      isBuy INTEGER NOT NULL
    )
  ''');
  }

  Future<int> insertProduct(ShoppingCartItem product) async {
    final db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  Future<List<ShoppingCartItem>> getAllItems() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return ShoppingCartItem.fromMap(maps[i]);
    });
  }

  Future<int> updateProduct(ShoppingCartItem product) async {
    final db = await instance.database;
    return await db.update('products', product.toMap(),
        where: 'id = ?', whereArgs: [product.id]);
  }

  Future<int> deleteProduct(int id) async {
    final db = await instance.database;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }
}
