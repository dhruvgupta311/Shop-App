import 'package:flutter/material.dart';
import '../provider/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widget/orders_item.dart';
import '../widget/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName='/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading=true;
      });
      await Provider.of<Orders>(context,listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading=false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final orderData=Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: 
        Text('Yours Orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading? Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx,i)=> OrderItem(orderData.orders[i]),
        ),
    );
  }
}