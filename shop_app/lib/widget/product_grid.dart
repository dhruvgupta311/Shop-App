import 'package:flutter/material.dart';
import '../provider/products_provider.dart';
import './product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final productsData= Provider.of<Products>(context);
   final products=productsData.items;// this is a list of product item accessed through above syntax by provider package
    return GridView.builder(  
    padding: const EdgeInsets.all(10.0),
    itemCount: products.length,
    itemBuilder: (ctx, i) => ChangeNotifierProvider(
      create: (c)  => products[i],
      child: ProductItem(),
      ),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 2/2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    );
  }
}