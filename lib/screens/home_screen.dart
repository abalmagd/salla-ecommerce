import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';
import 'package:salla/blocs/app_bloc/app_states.dart';
import 'package:salla/layout/search_layout.dart';
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
              CarouselSlider(
                items: cubit.home.data.banners
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
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Categories',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    child: Text(
                      'Show all',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    onPressed: () => cubit.changeBottomNavIndex(1),
                  ),
                ],
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  padding: EdgeInsets.all(8.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      cubit.dbInit();
                      cubit.getSearch(cubit.categories.data.data[index].name);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchLayout(
                            query: cubit.categories.data.data[index].name,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 2,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CachedNetworkImage(
                            width: 100,
                            fit: BoxFit.cover,
                            imageUrl: cubit.categories.data.data[index].image,
                          ),
                          Container(
                            width: 100.0,
                            color: Colors.black.withOpacity(0.5),
                            child: Text(
                              cubit.categories.data.data[index].name,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 10.0),
                  itemCount: AppCubit.get(context).categories.data.total,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Products',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => cubit.changeView(runtimeType, false),
                    icon: Icon(Icons.grid_view),
                    color: cubit.isList[runtimeType] ? Colors.grey : Theme.of(context).primaryColor,
                  ),
                  IconButton(
                    onPressed: () => cubit.changeView(runtimeType, true),
                    icon: Icon(Icons.list),
                    color: cubit.isList[runtimeType] ? Theme.of(context).primaryColor : Colors.grey,
                  ),
                ],
              ),
              Visibility(
                visible: cubit.isList[runtimeType],
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
