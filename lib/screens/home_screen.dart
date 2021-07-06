import 'package:carousel_slider/carousel_slider.dart';
import 'package:cirilla/blocs/app_bloc/app_cubit.dart';
import 'package:cirilla/blocs/app_bloc/app_states.dart';
import 'package:cirilla/models/category_model.dart';
import 'package:cirilla/models/home_model.dart';
import 'package:cirilla/models/product_model.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Shimmering effect enabled at initial state
    //bool _enabled = true;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        // End the shimmering effect if data received
        //if (state is AppGetHomeDataSuccessState) _enabled = false;
      },
      builder: (BuildContext context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.home != null && cubit.categories != null,
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                _carouselBuilder(banners: cubit.home.data.banners),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _sectionTitle(
                        context,
                        name: 'Categories',
                        onPressed: () {},
                      ),
                      SizedBox(height: 5),
                      // Horizontal ListView
                      Container(
                        height: 75.0,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => _listBuilder(
                            model: AppCubit.get(context).categories.data,
                            index: index,
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10.0),
                          itemCount:
                              AppCubit.get(context).categories.data.total,
                        ),
                      ),
                      SizedBox(height: 10),
                      _sectionTitle(
                        context,
                        name: 'Products',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                GridView.count(
                  padding: EdgeInsets.all(8),
                  childAspectRatio: 1.0 / 1.5,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: List.generate(
                      cubit.home.data.products.length,
                      (index) => _gridBuilder(
                          model: cubit.home.data.products[index],
                          context: context)),
                ),
              ],
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

CarouselSlider _carouselBuilder({
  @required List<Banners> banners,
}) {
  return CarouselSlider(
    items: banners
        .map(
          (e) => Image(
            image: NetworkImage(e.image),
          ),
        )
        .toList(),
    options: CarouselOptions(
      initialPage: 1,
      autoPlay: true,
      autoPlayAnimationDuration: Duration(seconds: 2),
      autoPlayCurve: Curves.fastOutSlowIn,
      enableInfiniteScroll: true,
      autoPlayInterval: Duration(seconds: 5),
      pauseAutoPlayOnTouch: true,
      viewportFraction: 1,
    ),
  );
}

Widget _sectionTitle(
  BuildContext context, {
  @required String name,
  @required VoidCallback onPressed,
}) {
  return Row(
    children: [
      Text(
        name,
        style: Theme.of(context).textTheme.headline5,
      ),
      Spacer(),
      TextButton(
        child: Text('Show all'),
        onPressed: onPressed,
      ),
    ],
  );
}

Widget _listBuilder({
  @required CategoryData model,
  @required int index,
}) {
  return GestureDetector(
    onTap: () {}, // TODO: Add on tap fn
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          width: 100,
          height: 100,
          // fit: BoxFit.cover,
          image: NetworkImage(model.data[index].image),
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.7),
          child: Text(
            model.data[index].name,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        ),
      ],
    ),
  );
}

Widget _gridBuilder({
  @required Product model,
  @required BuildContext context,
}) =>
    Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 4.0,
          ),
        ],
      ),
      // padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          likeButton(
            isLiked: false,
            onPressed: () {},
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image(
                    image: NetworkImage(model.image),
                    width: double.infinity,
                  ),
                ),
                if (model.discount > 0)
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
          ),
          Text(
            model.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Row(
            children: [
              Text(
                model.price.toString(),
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 5),
              if (model.discount > 0)
                Text(
                  model.oldPrice.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
