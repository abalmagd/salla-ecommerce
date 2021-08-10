import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';
import 'package:salla/blocs/app_bloc/app_states.dart';
import 'package:salla/models/product_model.dart';
import 'package:salla/widgets/favorite_button.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({
    Key key,
    @required this.product,
  });

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).changeProductViewedImage(image: product.image);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InteractiveViewer(
                minScale: 0.5,
                maxScale: 2.0,
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    height: 300,
                    imageUrl: AppCubit.get(context).productImage,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  color: Colors.blue,
                  height: 75,
                  width: product.images.length * 75.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        AppCubit.get(context)
                            .changeProductViewedImage(image: product.images[index]);
                      },
                      child: Container(
                        child: Image(image: NetworkImage(product.images[index])),
                        width: 75,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                    ),
                    itemCount: product.images.length,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              maxLines: 3,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          FavoriteButton(
                            onPressed: () => AppCubit.get(context).changeFavorite(product.id),
                            isLiked: AppCubit.get(context).favoriteList[product.id],
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Text(
                            product.price.toString(),
                            style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 18.0),
                          ),
                          SizedBox(width: 5),
                          Visibility(
                            visible: product.discount != null && product.discount > 0,
                            child: Text(
                              product.oldPrice.toString(),
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 20.0,
                            ),
                      ),
                      SizedBox(height: 4.0),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            product.description,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
