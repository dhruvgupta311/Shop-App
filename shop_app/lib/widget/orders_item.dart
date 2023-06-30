import 'package:flutter/material.dart';
import '../provider/orders.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final ord.OrderItem order; // isme jo orderitem h wo orders.dart ka h isiliye as ord import kiya h
  OrderItem(this.order);
  
// how each order will look like it will be stored in a card.
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(DateFormat('dd MM yyyy hh:mm').format(order.datetime),),
            trailing: IconButton(
            onPressed:(){}, 
             icon: Icon(
              Icons.expand_more_rounded,
              ),
             ),
          ),
        ],
      ),
    );
  }
}