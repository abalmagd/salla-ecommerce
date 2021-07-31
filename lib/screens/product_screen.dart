import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';
import 'package:salla/blocs/app_bloc/app_states.dart';
import 'package:salla/models/product_model.dart';
import 'package:salla/shared/styles/text.dart';
import 'package:salla/widgets/favorite_button.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).changeProductViewedImage(image: product.image);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              style: TextThemes.normalText(context),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 2.0,
                  child: Container(
                    color: Colors.white,
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: 300,
                      imageUrl: AppCubit.get(context).productImage,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Center(
                  child: Container(
                    height: 75,
                    width: product.images.length * 75.0,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          AppCubit.get(context).changeProductViewedImage(image: product.images[index]);
                        },
                        child: Container(
                          child: Image(image: NetworkImage(product.images[index])),
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.blue,
                          )),
                        ),
                      ),
                      itemCount: product.images.length,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        maxLines: 3,
                        style: TextThemes.normalText(context),
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
                    Text(product.price.toString(), style: TextThemes.itemPrice(context)),
                    SizedBox(width: 5),
                    Visibility(
                      visible: product.discount != null && product.discount > 0,
                      child: Text(
                        product.oldPrice.toString(),
                        style: TextThemes.itemOldPrice(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Text('Description', style: TextThemes.sectionHeader(context).copyWith(fontSize:
                16),),
                SizedBox(height: 4.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      product.description,
                      style: TextThemes.subText(context).copyWith(color: Colors.grey[900],
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
