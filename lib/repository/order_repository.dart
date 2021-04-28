import 'package:food_ordering/model/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ordering/model/order.dart';
import 'package:food_ordering/provider/firebase_auth_provider.dart';

class OrderRepository {
  static Future<List<Order>> fetchOrders(String uid) async {
    var ordersSnapshot = await FirebaseFirestore.instance.collection('orders').doc(uid).collection('orders').get();
    var orderDocs = ordersSnapshot.docs;
    var orders = orderDocs.map((e) => Order.fromMap(e.data()));
    return orders;
  }

  static void placeOrder(String uid, Order order) {
    FirebaseFirestore.instance.collection('orders').doc(uid).collection('orders').doc(order.uuid.toString()).set(order.toMap());
  }

  static void updateStatus(String uid, Order order) {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(uid)
        .collection('orders')
        .doc(order.uuid.toString())
        .update({'status': order.status.index});
  }

  static Stream<Order> orderStatusStream(int orderNumber) {
    return FirebaseFirestore.instance
        .collection('orders')
        .doc(AuthProvider.instance.currentUser.uid)
        .collection('orders')
        .doc(orderNumber.toString())
        .snapshots()
        .map((event) {
      print(event.data());
      print(event.data().runtimeType);
      print(event.data()['items'].runtimeType);
      return Order.fromMap(event.data());
    })
          ..listen((event) {
            print(event);
          });
  }
}
