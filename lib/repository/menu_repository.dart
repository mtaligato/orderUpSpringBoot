import 'package:food_ordering/model/menu_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuRepository {
  static Future<List<MenuItem>> fetchMenuItems(String uid) async {
    var menu = await FirebaseFirestore.instance.collection('menus').doc(uid).get();
    var menuItemsJson = menu.data()['items'] as List<dynamic>;
    var menuItems = menuItemsJson.map((e) => MenuItem.fromMap(e)).toList();
    return menuItems;
  }

  // static Future<List<MenuItem>> fetchMenuItemsByOwnerId(String uid) {
  //   var menuItemsJson = FirebaseFirestore.instance.collection('menus');
  // }

  static void uploadMenuItem(String uid, List<MenuItem> menuItems) {
    FirebaseFirestore.instance.collection('menus').doc(uid).set({
      'uid': uid,
      'items': FieldValue.arrayUnion(menuItems.map((e) => e.toMap()).toList()),
    });
  }
}
