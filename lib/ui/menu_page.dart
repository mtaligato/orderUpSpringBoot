import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/bloc/menu_bloc.dart';
import 'package:food_ordering/extension/widget_extension.dart';
import 'package:food_ordering/model/cart_item.dart';
import 'package:food_ordering/model/menu_item.dart';
import 'package:food_ordering/model/order.dart';
import 'package:food_ordering/provider/firebase_auth_provider.dart';
import 'package:food_ordering/repository/menu_repository.dart';
import 'package:food_ordering/repository/order_repository.dart';
import 'package:food_ordering/ui/order_status_page.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();

    MenuBloc.instance.fetchMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: Center(
          child: StreamBuilder(
        stream: MenuBloc.instance.menu,
        builder: (_, AsyncSnapshot<List<MenuItem>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                for (var item in snapshot.data)
                  ListTile(
                    key: ObjectKey(item),
                    title: Text(item.name),
                    subtitle: Text('\$${item.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: Icon(Icons.add), onPressed: () => addToCart(item)),
                      ],
                    ),
                  ),
              ],
            );
          }

          return Container();
        },
      )),
      floatingActionButton: StreamBuilder(
        stream: MenuBloc.instance.cart,
        builder: (_, AsyncSnapshot<List<CartItem>> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              onPressed: () => showCart(),
              label: Text(
                '\$${snapshot.data.map((e) => e.price).reduce((a, b) => a + b).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }

  void addToCart(MenuItem menuItem) {
    MenuBloc.instance.addItemToCart(menuItem);
  }

  void showCart() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            height: 1400,
            child: StreamBuilder(
              stream: MenuBloc.instance.cart,
              builder: (_, AsyncSnapshot<List<CartItem>> snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      for (var item in snapshot.data)
                        ListTile(
                          key: ObjectKey(item),
                          title: Text(item.name),
                          subtitle: Text('\$${item.price}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    MenuBloc.instance.removeItemFromCart(item);
                                  }),
                            ],
                          ),
                        ),
                      ListTile(
                        title: Text('Total: \$${snapshot.data.map((e) => e.price).reduce((a, b) => a + b).toStringAsFixed(2)}'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showPlaceOrderDialog(snapshot.data);
                        },
                        child: Container(
                          height: 36,
                          child: Center(
                            child: Text('Place Order'),
                          ),
                        ),
                      ).padding(horizontal: 48),
                    ],
                  );
                }

                return Container();
              },
            ),
          );
        });
  }

  void showPlaceOrderDialog(List<CartItem> items) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Place Order'),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(labelText: 'Phone'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    var order = Order(items, nameController.text, phoneController.text, OrderStatus.placed);
                    OrderRepository.placeOrder(AuthProvider.instance.currentUser.uid, order);
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => OrderStatusPage(orderNumber: order.uuid)));
                  },
                  child: Text('OK')),
            ],
          );
        });
  }
}
