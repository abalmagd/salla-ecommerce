import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';
import 'package:salla/blocs/app_bloc/app_states.dart';
import 'package:salla/models/favourites_model.dart';
import 'package:salla/screens/no_data_screen.dart';
import 'package:salla/widgets/product_grid_builder.dart';
import 'package:salla/widgets/product_list_builder.dart';

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
                        color: AppCubit.get(context).isList[runtimeType]
                            ? Colors.grey
                            : Theme.of(context).primaryColor,
                      ),
                      IconButton(
                        onPressed: () => AppCubit.get(context).changeView(runtimeType, true),
                        icon: Icon(Icons.list),
                        color: AppCubit.get(context).isList[runtimeType]
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
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
