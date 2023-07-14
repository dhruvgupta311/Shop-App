import 'package:flutter/material.dart';
import '../screen/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';
import '../provider/cart.dart';
import '../provider/auth.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id,this.title,this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    /*ye product class ka naaam h in angular brackets in prducty.dart*/
    //product ke andar product.dart ki sari info by above syntax provided by provider package
    final cart = Provider.of<Cart>(context, listen: false);
    final authData=Provider.of<Auth>(context,listen: false);
    return ClipRRect(
      // clipreact is widget which fits perfectly in grid or any other widget
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: () {
                product.toogleFavoriteStatus(authData.token.toString(),authData.userId.toString());
              },
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Colors.red,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItems(product.id!, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added item to cart!',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id!);
                    },
                  ),
                ),
              );
            },
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
// consumer is a widegt taken from the provider package which always listen to the changes 
//whereas when we declared product as listen false we declare that it will not listen to the 
// changes occurs so we only wrap isfavorite icon because it only needs to be rebuiltd
//when any vhanges occurs so we wrap that in consumer   
// thing which will be written in child of consumer widget will never changes