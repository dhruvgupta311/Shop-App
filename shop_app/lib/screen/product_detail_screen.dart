import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/products_provider.dart';

class ProductDetailScreen extends StatelessWidget{
//   final String title;
//   final String price;
 static const routeName = '/product_detail';
// ProductDetailScreen(this.title,this.price);

  @override
  Widget build(BuildContext context){
   final productId = ModalRoute.of(context)?.settings.arguments as String;
     final loadedProduct =Provider.of<Products>(context, listen: false).findById(productId);
        // product id me saree product ki id hogi to to bhi tap hoga uska title aa jaaega on app bar
        // false kr diya rto jb notifylistener ise render krega tb ye rebuild nhi hoga
   return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}