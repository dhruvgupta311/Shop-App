import 'package:flutter/material.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
   List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  // var _showFavoriteOnly=false;
  final String authToken;
  final String userId;
  Products(this.authToken,this.userId,this._items);

  List<Product> get items {
    // if(_showFavoriteOnly){
    //   return _items.where((prodItem)=>prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get favoritesItems {
    List<Product> favProducts = [];
    for (var prodItem in _items) {
      if (prodItem.isFavorite) {
        favProducts.add(prodItem);
      }
    }
    return favProducts;
    // return _items.where((prodItem) => prodItem.isFavorite).toList();
  }
  // void showFavoriteOnly(){
  //   _showFavoriteOnly=true;
  //     notifyListeners();
  // }

  // void showAll(){
  //   _showFavoriteOnly=false;
  //     notifyListeners();
  // }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
       final url = 'https://shopapp-89b85-default-rtdb.firebaseio.com/products_provider/$id.json?auth=$authToken';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

 Future<void> delete(String id) async {
  final url = 'https://shopapp-89b85-default-rtdb.firebaseio.com/products_provider/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex] as Product?;
    
      _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct!);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
    }
    
  Future<void> fetchAndSetProducts([bool filterByUser =false]) async {
    final filterString=filterByUser? 'orderBy="creatorId"&equalTo="$userId"':'';
    var url = 'https://shopapp-89b85-default-rtdb.firebaseio.com/products_provider.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if(extractedData==null){
        return;
      }
       url = 'https://shopapp-89b85-default-rtdb.firebaseio.com/products_provider.json?auth=$authToken&orderBy="creatorId"&equalTo="$userId"';
      final favoriteResponse=await http.get(Uri.parse(url));
      final favoriteData=json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      // ab kya hoga ki jo bhi data ase me product h uske liye loop chalega jisme prodID wounique id h jo
      // firebase ka realtime database prrovide krwa rha h
      extractedData.forEach((prodId, prodData){
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: favoriteData==null? false : favoriteData[prodId]?? false,
          imageUrl: prodData['imageUrl'],
        ));
      });
      //print('object');
      _items=loadedProducts;
      notifyListeners();
    }catch (error){
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://shopapp-89b85-default-rtdb.firebaseio.com/products_provider.json?auth=$authToken';
      try{
      final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'isFavorite': product.isFavorite,
        'creatorId':userId,
      }),);
       final newProduct = Product(
      id: json.decode(response.body)['name'],
      // by this we will get the id generated by firebass it will be unique for every product added
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,

    );
    _items.add(newProduct);
    notifyListeners();
      }catch(error){
        print(error);
        throw(error);
      }
    //_items.add(product);
     //return Future.value();
  }
}
