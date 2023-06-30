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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              loadedProduct.imageUrl,
              fit:BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '\$${loadedProduct.price}',
            style: TextStyle(
              color: Color.fromARGB(255, 5, 0, 0),
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              style: TextStyle(
              color: Color.fromARGB(255, 5, 0, 0),
              fontSize: 20,
            ),
              loadedProduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          )
         ],
        ),
      ),
    );
  }
}