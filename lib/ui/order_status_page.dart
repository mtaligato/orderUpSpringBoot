import 'package:flutter/material.dart';
import 'package:food_ordering/model/order.dart';
import 'package:food_ordering/repository/order_repository.dart';

class OrderStatusPage extends StatefulWidget {
  final int orderNumber;

  const OrderStatusPage({Key key, @required this.orderNumber}) : super(key: key);

  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order ${widget.orderNumber}'),
        ),
        body: StreamBuilder(
          stream: OrderRepository.orderStatusStream(widget.orderNumber),
          builder: (_, AsyncSnapshot<Order> snapshot) {
            if (snapshot.hasData) {
              var order = snapshot.data;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('${order.status}'), Text('test')],
              );
            }

            return Container();
          },
        ));
  }
}
