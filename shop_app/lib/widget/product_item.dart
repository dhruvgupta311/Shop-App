import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shop_app/provider/products_provider.dart';
import '../screen/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id,this.title,this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product=Provider.of<Product>(context,listen: false);
    /*ye product class ka naaam h in angular brackets in prducty.dart*/ 
    //product ke andar product.dart ki sari info by above syntax provided by provider package
    return ClipRRect( // clipreact is widget which fits perfectly in grid or any other widget
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap:(){
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
            arguments:product.id,);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover
            ),
        ),
          footer: GridTileBar(
              backgroundColor: Colors.black87,
               leading: IconButton(
                onPressed: () {
                  product.toogleFavoriteStatus();
                },
                 icon: Icon(
                  product.isFavorite? Icons.favorite : Icons.favorite_border,
                ),
                color: Colors.red,
              ),
              trailing:
                  IconButton(
                    onPressed: () {}, 
                    icon: Icon(Icons.shopping_cart),
                    color: Color.fromARGB(255, 252, 252, 252),
                    ),
            title: Text(
              product.title,
                textAlign: TextAlign.center,
              ),
            ),
         ),
    );
  }
}