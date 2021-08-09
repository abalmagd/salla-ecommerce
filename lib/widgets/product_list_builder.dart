import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';
import 'package:salla/models/favourites_model.dart';
import 'package:salla/models/product_model.dart';
import 'package:salla/screens/product_screen.dart';

import 'favorite_button.dart';

class ListBuilder extends StatelessWidget {
  final List<Product> products;
  final List<Datum> favorites;
  final bool shrinkWrap;

  const ListBuilder({
    this.products,
    this.shrinkWrap = false,
    this.favorites,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? NeverScrollableScrollPhysics() : null,
      padding: EdgeInsets.all(8.0),
      itemBuilder: (context, index) => ListItemBuilder(
        product: products == null ? favorites[index].product : products[index],
      ),
      separatorBuilder: (context, index) => SizedBox(height: 10.0),
      itemCount: products == null ? favorites.length : products.length,
    );
  }
}

class ListItemBuilder extends StatelessWidget {
  final Product product;

  const ListItemBuilder({Key key, this.product}) : super(key: key);

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
        child: Row(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  color: Colors.white,
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    height: 150,
                    width: 150,
                  ),
                ),
                if (product.discount != null && product.discount > 0)
                  Container(
                    padding: EdgeInsets.all(2),
                    color: Colors.cyan,
                    child: Text(
                      'DISCOUNT',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 14.0),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          product.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          product.price.toString(),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(width: 5),
                        if (product.discount != null && product.discount > 0)
                          Text(
                            product.oldPrice.toString(),
                            style: Theme.of(context).textTheme.subtitle2.copyWith(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 3.0,
                                ),
                          ),
                        Spacer(),
                        FavoriteButton(
                          isLiked: AppCubit.get(context).favoriteList[product.id],
                          onPressed: () => AppCubit.get(context).changeFavorite(product.id),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*Container(
      padding: EdgeInsets.all(8.0),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            // offset: Offset(0.0, 0.0), //(x,y)
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              CachedNetworkImage(
                imageUrl: product.image,
                height: 150,
                width: 150,
              ),
              if (product.discount != null && product.discount > 0)
                Container(
                  padding: EdgeInsets.all(2),
                  color: Colors.red,
                  child: Text('DISCOUNT', style: TextStyle(color: Colors.white)),
                ),
            ],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      product.price.toString(),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(width: 5),
                    if (product.discount != null && product.discount > 0)
                      Text(
                        product.oldPrice.toString(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    Spacer(),
                    FavoriteButton(
                      isLiked: AppCubit.get(context).favoriteList[product.id],
                      onPressed: () => AppCubit.get(context).changeFavorite(product.id),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    )*/
