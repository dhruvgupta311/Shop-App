import 'package:flutter/material.dart';
import 'package:shop_app/provider/orders.dart';
import 'package:shop_app/screen/splash_screen.dart';
import './provider/products_provider.dart';
import './screen/product_overview_screen.dart';
import 'package:provider/provider.dart';
import './screen/product_detail_screen.dart';
import './provider/cart.dart';
import './screen/cart_screen.dart';
import './screen/orders_screen.dart';
import './screen/users_products_screen.dart';
import './screen/edit_product_screen.dart';
import 'screen/auth_screen.dart';
import './provider/auth.dart';
import './screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (context, auth, previousProducts) => Products(
              auth.token.toString(),
              auth.userId.toString(),
              previousProducts == null ? [] : previousProducts.items),
          create: (context) =>
              Products('','', []), // Provide a default instance of Products here
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
         ChangeNotifierProxyProvider<Auth, Orders>(
          update: (context, auth, previousProducts) => Orders(
              auth.token.toString(),
              auth.userId.toString(),
              previousProducts == null ? [] : previousProducts.orders),
          create: (context) =>
              Orders('','', []), // Provide a default instance of Products here
        ),
      ],

      //  This callback function is called when the ChangeNotifierProvider widget is first built, and it provides a new instance of Products to the widget tree.
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            fontFamily: 'Raleway',
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                future:auth.tryAutoLogin(),
                builder: (ctx,authResultSnapshot)=>authResultSnapshot.connectionState==ConnectionState.waiting? SplashScreen(): AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
