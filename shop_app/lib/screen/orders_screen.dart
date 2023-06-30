import 'package:flutter/material.dart';
import '../provider/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widget/orders_item.dart';
import '../widget/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName='/orders';

  @override
  Widget build(BuildContext context) {
    final orderData=Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: 
        Text('Yours Orders'),
      ),
      drawer: AppDrawer(),
      body:ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx,i)=> OrderItem(orderData.orders[i]),
        ),
    );
  }
}