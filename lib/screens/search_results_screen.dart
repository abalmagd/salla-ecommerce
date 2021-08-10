import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';
import 'package:salla/blocs/app_bloc/app_states.dart';
import 'package:salla/screens/no_data_screen.dart';
import 'package:salla/widgets/product_list_builder.dart';
import 'package:salla/widgets/widgets.dart';

class SearchResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) => ConditionalBuilder(
        condition: AppCubit.get(context).searchResults != null,
        builder: (context) => SingleChildScrollView(
          child: Visibility(
            visible: AppCubit.get(context).searchResults.data.data.length > 0,
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
                    products: AppCubit.get(context).searchResults.data.data,
                  ),
                  replacement: GridBuilder(
                    products: AppCubit.get(context).searchResults.data.data,
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
            replacement: Center(child: NoDataScreen()),
          ),
        ),
        fallback: (context) => Center(
            child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        )),
      ),
    );
  }
}
