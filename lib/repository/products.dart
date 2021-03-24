import 'package:busymed_assessment/models/products.dart';
import 'package:busymed_assessment/services/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsRepository with ChangeNotifier {
  static const String FAVOURITES_KEY = 'saved_favourites_key';

  SharedPreferences _sharedPreferences;
  List<Product> _products = [];
  List<Product> _favourites = [];
  bool _loading = false;

  ProductsRepository() {
    SharedPreferences.getInstance().then((instance) => _sharedPreferences = instance);
  }

  fetchProducts() {
    /// check if null or empty so it only fetches products on app start
    if (_products == null || _products.isEmpty) {
      _loading = true;
      notifyListeners();
      ApiService().getApiData('https://dev.busymed.com/api/products_top_20').then((response) {
        try {
          Products productsModel = productsFromJson(response);
          _products = productsModel.products;
          _checkUserFavourites();
          _loading = false;
          notifyListeners();
        } catch (error, stacktrace) {
          _products = null;
          _loading = false;
          notifyListeners();
          print('Exception occured: $error stackTrace: $stacktrace');
        }
      }).catchError((onError) {
        _products = null;
        _loading = false;
        notifyListeners();
      });
    }
  }

  void _checkUserFavourites() {
    if (persistedFavourites != null && persistedFavourites.isNotEmpty) _syncFavourites(persistedFavourites);
  }

  List<Product> get products => _products;
  bool get loading => _loading;
  List<Product> get favourites {
    _favourites.sort((a, b) => a.name.compareTo(b.name));
    return _favourites;
  }

  ///Persist favourites
  List<String> get persistedFavourites => _sharedPreferences.getStringList(FAVOURITES_KEY);
  void persistFavourites(List<String> ids) => _sharedPreferences.setStringList(FAVOURITES_KEY, ids);

  void setFavourite(Product favourite) {
    int index = _favourites.indexWhere((Product fave) => fave.id == favourite.id);
    if (index > -1) {
      _favourites.removeAt(index);
    } else {
      _favourites.add(favourite);
    }
    Product product = _products.firstWhere((Product product) => product.id == favourite.id);
    product.favourite = !product.favourite;
    persistFavourites(_favourites.map((Product favourite) => favourite.id.toString()).toList());
    notifyListeners();
  }

  void _syncFavourites(List<String> ids) {
    ids.forEach((String id) {
      Product product = _products.firstWhere((Product product) => product.id.toString() == id);
      setFavourite(product);
    });
  }
}
