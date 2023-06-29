import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screen/cart_screen.dart';
import '../widget/product_grid.dart';
import '../provider/cart.dart';
import './cart_screen.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    // final productsContainer=Provider.of<Products>(context,listen: false);
    //final cart=Provider.of<Cart>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showFavoriteOnly = true;
                  // productsContainer.showFavoriteOnly();
                } else {
                  _showFavoriteOnly = false;
                  // productsContainer.showAll();
                }
              });
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Show all'),
              ),
            ],
          ),
          Consumer<Cart>(builder: (_,cart,ch)=>  Badge(
           child: ch,
            label: Text(cart.itemCount.toString()),
            ),
            child: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ), 
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            ),
          ),
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}
