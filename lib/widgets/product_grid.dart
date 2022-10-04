import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_item.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavs;
  ProductGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showFavs ? productsData.FavoritesItems : productsData.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //changenotifierProvider cleans the previous data
        value: products[i],
        child: ProductItem(
            // products[i].id, products[i].title, products[i].imageUrl
            ),
      ),
      padding: EdgeInsets.all(10),
      itemCount: products.length,
    );
  }
}
