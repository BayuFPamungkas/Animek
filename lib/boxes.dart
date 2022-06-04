import 'package:hive/hive.dart';
import 'package:anime_flutter/models/cart.dart';
class HiveBoxes {
  static Box<Item> getItems() =>
    Hive.box<Item>('items');
}