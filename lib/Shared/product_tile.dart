import 'package:busymed_assessment/models/products.dart';
import 'package:busymed_assessment/repository/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: product.image != null
          ? Container(width: 40, child: Image.network('https://dev.busymed.com/product/${product.image}'))
          : Container(
              width: 40,
            ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            product.brand.name,
            style: TextStyle(fontSize: 12),
          ),
          Text(
            product.type?.name ?? '',
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
      trailing: IconButton(
        onPressed: () {
          Provider.of<ProductsRepository>(context, listen: false).setFavourite(product);
        },
        icon: product.favourite
            ? Icon(
                Icons.favorite,
                color: Theme.of(context).accentColor,
              )
            : Icon(
                Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ),
      ),
    );
  }
}
