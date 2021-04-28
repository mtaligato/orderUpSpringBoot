import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/bloc/menu_bloc.dart';
import 'package:food_ordering/extension/widget_extension.dart';
import 'package:food_ordering/model/menu_item.dart';
import 'package:food_ordering/provider/firebase_auth_provider.dart';
import 'package:food_ordering/repository/menu_repository.dart';

class MenuEditPage extends StatefulWidget {
  @override
  _MenuEditPageState createState() => _MenuEditPageState();
}

class _MenuEditPageState extends State<MenuEditPage> {
  @override
  void initState() {
    super.initState();

    MenuBloc.instance.fetchMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showAddDialog();
              })
        ],
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
                        IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                        SizedBox(
                          width: 24,
                        ),
                        IconButton(icon: Icon(Icons.delete), onPressed: () => showConfirmDelete(item)),
                      ],
                    ),
                  ),
              ],
            );
          }

          return Container();
        },
      )),
    );
  }

  void showConfirmDelete(MenuItem item) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Delete ${item.name}?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    MenuBloc.instance.deleteItem(item);
                    Navigator.pop(context);
                  },
                  child: Text('Confirm')),
            ],
          );
        });
  }

  void showAddDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Add an Item'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Item Name'),
                  ),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: 'Item Price'),
                    validator: (txt) {
                      if (double.tryParse(txt) == null) {
                        return 'Invalid price.';
                      } else {
                        return null;
                      }
                    },
                  )
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      Navigator.pop(context);
                      var item = MenuItem(nameController.text, double.parse(priceController.text), '');
                      MenuBloc.instance.addItem(item);
                    }
                  },
                  child: Text('Add')),
            ],
          );
        });
  }
}
