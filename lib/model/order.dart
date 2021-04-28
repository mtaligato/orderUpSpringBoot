import 'dart:math';

import 'cart_item.dart';

enum OrderStatus {
  placed,
  preparing,
  waiting,
}

class Order {
  final List<CartItem> items;
  final int timestamp;
  final String name;
  final String phoneNumber;
  final OrderStatus status;
  final uuid;

  Order(this.items, this.name, this.phoneNumber, this.status)
      : timestamp = DateTime.now().millisecondsSinceEpoch,
        uuid = generateOrderNumber();

  Order.fromMap(Map map)
      : items = (map['items'] as List).cast<Map<String, dynamic>>().map((e) => CartItem.fromMap(e)).toList(),
        timestamp = map['timestamp'],
        name = map['name'],
        phoneNumber = map['phoneNumber'],
        status = OrderStatus.values.elementAt(map['status']),
        uuid = map['uuid'];

  Map toMap() => {
        'items': items.map((e) => e.toMap()).toList(),
        'timestamp': timestamp,
        'name': name,
        'phoneNumber': phoneNumber,
        'status': status.index,
        'uuid': uuid
      }.cast<String, dynamic>();

  static int generateOrderNumber() {
    int orderNumber = 0;

    while (orderNumber.toString().length < 4) {
      orderNumber = Random().nextInt(10000);
    }

    return orderNumber;
  }
}
