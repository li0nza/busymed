import 'package:busymed_assessment/Shared/loader.dart';
import 'package:busymed_assessment/Shared/product_tile.dart';
import 'package:busymed_assessment/models/products.dart';
import 'package:busymed_assessment/repository/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FavouritesWidget extends StatefulWidget {
  @override
  _FavouritesWidgetState createState() => _FavouritesWidgetState();
}

class _FavouritesWidgetState extends State<FavouritesWidget> {
  Products productsModel;
  ProductsRepository productsRepository;

  @override
  void initState() {
    super.initState();
    productsRepository = Provider.of<ProductsRepository>(context, listen: false);
  }

  Widget _getEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Please go to Products page and select some favourites.'),
        ],
      ),
    );
  }

  Widget _getBody() {
    if (productsRepository.loading) return LoaderWidget();
    if (productsRepository.favourites == null || productsRepository.favourites.isEmpty) return _getEmptyState();
    List<Product> products = productsRepository.favourites;
    return Container(
      padding: EdgeInsets.only(top: 12),
      child: ListView.separated(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductTile(products[index]);
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Favourites'), Text('Total: ${productsRepository.favourites.length}')],
          ),
        ),
        body: Consumer<ProductsRepository>(builder: (BuildContext ctx, ProductsRepository __, Widget _) {
          return _getBody();
        }));
  }
}
