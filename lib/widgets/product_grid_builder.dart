import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';
import 'package:salla/models/favourites_model.dart';
import 'package:salla/models/product_model.dart';
import 'package:salla/screens/product_screen.dart';
import 'package:salla/shared/styles/text.dart';
import 'package:salla/widgets/widgets.dart';

/// Re-usable widget for creating grid for products
/// takes a [List] of [Product]

class GridBuilder extends StatelessWidget {
  final List<Product> products;
  final List<Datum> favorites;
  final bool shrinkWrap;

  const GridBuilder({
    this.products,
    this.favorites,
    this.shrinkWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(8.0),
      childAspectRatio: 1.0 / 1.1,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? NeverScrollableScrollPhysics() : null,
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: List.generate(
        products == null ? favorites.length : products.length,
        (index) => GridItemBuilder(
          product: products == null ? favorites[index].product : products[index],
        ),
      ),
    );
  }
}

class GridItemBuilder extends StatelessWidget {
  final Product product;

  const GridItemBuilder({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductScreen(
            product: product,
          ),
        ),
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  color: Colors.white,
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    width: double.infinity,
                    height: 150,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: FavoriteButton(
                    isLiked: AppCubit.get(context).favoriteList[product.id],
                    onPressed: () => AppCubit.get(context).changeFavorite(product.id),
                  ),
                ),
                if (product.discount != null && product.discount > 0)
                  Container(
                    padding: EdgeInsets.all(2),
                    color: Colors.red,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextThemes.normalText(context),
            ),
            SizedBox(height: 6.0),
            Row(
              children: [
                Text(product.price.toString(), style: TextThemes.itemPrice(context)),
                SizedBox(width: 5),
                if (product.discount != null && product.discount > 0)
                  Text(
                    product.oldPrice.toString(),
                    style: TextThemes.itemOldPrice(context),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
