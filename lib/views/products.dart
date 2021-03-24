import 'package:busymed_assessment/Shared/loader.dart';
import 'package:busymed_assessment/Shared/product_tile.dart';
import 'package:busymed_assessment/models/products.dart';
import 'package:busymed_assessment/repository/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProductsWidget extends StatefulWidget {
  @override
  _ProductsWidgetState createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  Products productsModel;
  ProductsRepository productsRepository;

  @override
  void initState() {
    super.initState();
    productsRepository = Provider.of<ProductsRepository>(context, listen: false);
    productsRepository.fetchProducts();
  }

  Widget _getEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Fetching data failed.'),
          ElevatedButton(
            child: Text('Retry'),
            onPressed: () => productsRepository.fetchProducts(),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
          ),
        ],
      ),
    );
  }

  Widget _getBody() {
    if (productsRepository.loading) return LoaderWidget();
    if (productsRepository.products == null || productsRepository.products.isEmpty) return _getEmptyState();
    List<Product> products = productsRepository.products;
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
        title: Text('Products'),
      ),
      body: Consumer<ProductsRepository>(builder: (BuildContext ctx, ProductsRepository __, Widget _) {
        return _getBody();
      }),
    );
  }
}
