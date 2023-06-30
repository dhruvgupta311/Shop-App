import 'package:flutter/material.dart';
import '../provider/orders.dart' as ord;
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order; // isme jo orderitem h wo orders.dart ka h isiliye as ord import kiya h
  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
// how each order will look like it will be stored in a card.
var _expanded=false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
               ),),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(widget.order.datetime),
               style: TextStyle(
                fontWeight: FontWeight.bold,
               ),
              ),
            trailing: IconButton(
            onPressed:(){
              setState(() {
                _expanded=!_expanded;
              });
            }, 
             icon: Icon(
              _expanded?  Icons.expand_less : Icons.expand_more,
              ),
             ),
          ),
          if(_expanded) Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
            height: min(widget.order.products.length*20.0 +10,180),
            child: ListView(
              // maps take the value which runs on the evry item index
              children: widget.order.products.map((prod)=>
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(prod.title,style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text('\$${prod.quantity}x \$${prod.price}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                 ),
                ],
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}