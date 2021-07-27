import 'package:cirilla/blocs/app_bloc/app_cubit.dart';
import 'package:cirilla/blocs/app_bloc/app_states.dart';
import 'package:cirilla/models/favourites_model.dart';
import 'package:cirilla/screens/no_data_screen.dart';
import 'package:cirilla/widgets/product_grid_builder.dart';
import 'package:cirilla/widgets/product_list_builder.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Datum> favorites;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          favorites = AppCubit.get(context).favorites.data.data;
          return ConditionalBuilder(
            condition: favorites != null && favorites.length > 0,
            builder: (BuildContext context) => SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                      favorites: AppCubit.get(context).favorites.data.data,
                    ),
                    replacement: GridBuilder(
                      favorites: AppCubit.get(context).favorites.data.data,
                      shrinkWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            fallback: (ctx) => NoDataScreen(),
          );
        });
  }
}
