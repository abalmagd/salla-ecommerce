import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';
import 'package:salla/blocs/app_bloc/app_states.dart';
import 'package:salla/layout/search_layout.dart';
import 'package:salla/models/category_model.dart';
import 'package:salla/models/home_model.dart';
import 'package:salla/shared/styles/text.dart';
import 'package:salla/widgets/product_list_builder.dart';
import 'package:salla/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) => ConditionalBuilder(
        condition: cubit.home != null && cubit.categories != null,
        builder: (context) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Banner(banners: cubit.home.data.banners),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Categories',
                      style: TextThemes.sectionHeader(context),
                    ),
                    Spacer(),
                    TextButton(
                      child: Text('Show all'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                child: CategoryListBuilder(data: cubit.categories.data),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Products',
                        style: TextThemes.sectionHeader(context),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => AppCubit.get(context).changeView(runtimeType, false),
                    icon: Icon(Icons.grid_view),
                    color: AppCubit.get(context).isList[runtimeType] ? Colors.black : Colors.blue,
                  ),
                  IconButton(
                    onPressed: () => AppCubit.get(context).changeView(runtimeType, true),
                    icon: Icon(Icons.list),
                    color: AppCubit.get(context).isList[runtimeType] ? Colors.blue : Colors.black,
                  ),
                ],
              ),
              Visibility(
                visible: AppCubit.get(context).isList[runtimeType],
                child: ListBuilder(
                  shrinkWrap: true,
                  products: cubit.home.data.products,
                ),
                replacement: GridBuilder(
                  products: cubit.home.data.products,
                ),
              ),
            ],
          ),
        ),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({
    Key key,
    @required this.banners,
  }) : super(key: key);

  final List<Banners> banners;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: banners
          .map(
            (e) => CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: e.image,
            ),
          )
          .toList(),
      options: CarouselOptions(
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
}

class CategoryListBuilder extends StatelessWidget {
  const CategoryListBuilder({
    Key key,
    @required this.data,
  }) : super(key: key);
  final CategoryData data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => CategoryListItemBuilder(
        model: data,
        index: index,
      ),
      separatorBuilder: (context, index) => SizedBox(width: 10.0),
      itemCount: AppCubit.get(context).categories.data.total,
    );
  }
}

class CategoryListItemBuilder extends StatelessWidget {
  final CategoryData model;
  final int index;

  const CategoryListItemBuilder({
    this.model,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppCubit.get(context).dbInit();
        AppCubit.get(context).getSearch(model.data[index].name);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchLayout(
              query: model.data[index].name,
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CachedNetworkImage(
              width: 100,
              fit: BoxFit.cover,
              imageUrl: model.data[index].image,
            ),
            Container(
              width: 100.0,
              color: Colors.black.withOpacity(0.5),
              child: Text(
                model.data[index].name,
                textAlign: TextAlign.center,
                style: TextThemes.subText(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
