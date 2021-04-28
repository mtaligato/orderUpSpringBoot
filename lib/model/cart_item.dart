import 'package:food_ordering/model/menu_item.dart';
import 'package:uuid/uuid.dart';

class CartItem {
  final String name;
  final double price;
  final String uuid;

  CartItem({this.name, this.price, this.uuid});

  CartItem.fromMenuItem(MenuItem menuItem)
      : name = menuItem.name,
        price = menuItem.price,
        uuid = Uuid().v1();

  CartItem.fromMap(Map map)
      : name = map['name'],
        price = map['price'],
        uuid = map['uuid'];

  Map toMap() => {
        'name': name,
        'price': price,
        'uuid': uuid,
      };
}
