import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import '../widget/cart_item.dart' as ci;
import '../provider/orders.dart';
class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

//this is screen when we click on the cart icon 
  @override
  Widget build(BuildContext context) {
    //this cart willl now can access all information of Cart class with dot operator. 
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('\$${cart.totalAmount}'),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<Orders>(context,listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount
                        );
                        cart.clear();
                    },
                    child: Text(
                      'Order Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx,i)=> ci.CartItem(
                cart.items.values.toList()[i].id, 
                cart.items.keys.toList()[i],
                 cart.items.values.toList()[i].price, 
                 cart.items.values.toList()[i].quantity, 
                 cart.items.values.toList()[i].title,
                ),
                itemCount: cart.items.length,
                ),
             ),
        ],
      ),
    );
  }
}
