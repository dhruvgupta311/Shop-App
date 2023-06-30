import 'package:flutter/material.dart';
import 'package:shop_app/provider/orders.dart';
import './provider/products_provider.dart';
import './screen/product_overview_screen.dart';
import 'package:provider/provider.dart';
import './screen/product_detail_screen.dart';
import './screen/product_overview_screen.dart';
import './provider/products_provider.dart';
import './provider/cart.dart';
import './screen/cart_screen.dart';
import './provider/orders.dart';
import './screen/orders_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:(ctx)=> Products(),// or by value
        ),
        ChangeNotifierProvider(
          create:(ctx)=> Cart(),
        ),
         ChangeNotifierProvider(
          create:(ctx)=> Orders(),
        ),
      ],

      //  This callback function is called when the ChangeNotifierProvider widget is first built, and it provides a new instance of Products to the widget tree.
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            fontFamily: 'Raleway',
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName:(ctx)=>CartScreen(),
            OrdersScreen.routeName:(ctx)=>OrdersScreen(),
          }),
    );
    
  }
}
