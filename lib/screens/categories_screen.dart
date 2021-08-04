import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';
import 'package:salla/layout/search_layout.dart';
import 'package:salla/models/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    List<CategoryItem> categories = cubit.categories.data.data;
    return ConditionalBuilder(
      condition: cubit.categories != null,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              cubit.dbInit();
              cubit.getSearch(categories[index].name);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchLayout(
                            query: categories[index].name,
                          )));
            },
            contentPadding: EdgeInsets.all(4.0),
            leading: CachedNetworkImage(
              imageUrl: categories[index].image,
              width: 100,
              fit: BoxFit.cover,
            ),
            title: Align(
              alignment: Alignment.center,
              child: Text(
                categories[index].name,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
            trailing: Icon(Icons.arrow_forward),
          ),
          separatorBuilder: (context, index) => Divider(),
          itemCount: categories.length,
        ),
      ),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );
  }
}
