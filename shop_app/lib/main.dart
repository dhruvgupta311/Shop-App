import 'package:flutter/material.dart';
import './provider/products_provider.dart';
import './screen/product_overview_screen.dart';
import 'package:provider/provider.dart';
import './screen/product_detail_screen.dart';
import './screen/product_overview_screen.dart';
import './provider/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>.value(
          value: Products(),
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
          }),
    );
  }
}
