import 'package:flutter/material.dart';
import '../widget/product_item.dart';
import '../widget/product_grid.dart';

enum FilterOptions{
  Favorites,
  All,
}


class ProductsOverviewScreen extends StatefulWidget{
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoriteOnly=false;
  @override
  Widget build(BuildContext context){
    // final productsContainer=Provider.of<Products>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue){
              setState(() {
                if(selectedValue==FilterOptions.Favorites){
                _showFavoriteOnly=true;
                // productsContainer.showFavoriteOnly();
              }
              else{
                _showFavoriteOnly=false;
                // productsContainer.showAll();
              }
              });
              
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_)=>[
              PopupMenuItem(child: Text('Only Favorites'),value :FilterOptions.Favorites),
              PopupMenuItem(child: Text('Show all'),value :FilterOptions.All),
            ],
          ),
        ],
      ),
      body:ProductGrid(_showFavoriteOnly),
   );
  }
}
