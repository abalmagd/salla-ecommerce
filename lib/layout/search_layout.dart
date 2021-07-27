import 'package:cirilla/blocs/app_bloc/app_cubit.dart';
import 'package:cirilla/blocs/app_bloc/app_states.dart';
import 'package:cirilla/screens/search_results_screen.dart';
import 'package:cirilla/screens/search_screen.dart';
import 'package:cirilla/shared/local/sqflite_helper.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchLayout extends StatelessWidget {
  static final TextEditingController searchController = TextEditingController();
  final String query;
  final FocusNode _node = FocusNode();

  SearchLayout({Key key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    searchController.value = TextEditingValue(text: query ?? '');
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 30,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  SqfliteHelper.dbClose();
                  searchController.clear();
                  AppCubit.get(context).searchResults = null;
                  AppCubit.get(context).isSearching = false;
                  // searchController.dispose();
                  Navigator.pop(context);
                },
              ),
              title: Container(
                height: 34,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(
                  focusNode: _node,
                  onChanged: (text) {
                    if (text.isEmpty) {
                      AppCubit.get(context).isSearching = false;
                      AppCubit.get(context).searchResults = null;
                      AppCubit.get(context).emit(SearchScreenState());
                    } else {
                      // AppCubit.get(context).isSearching = true;
                      // don't spam
                      // AppCubit.get(context).getSearch(text);
                    }
                  },
                  onSubmitted: (text) {
                    AppCubit.get(context).getSearch(text);
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.close, size: 17),
                        onPressed: () {
                          searchController.clear();
                          _node.unfocus();
                          AppCubit.get(context).isSearching = false;
                          AppCubit.get(context).searchResults = null;
                          AppCubit.get(context).emit(SearchScreenState());
                        }),
                  ),
                ),
              ),
            ),
            body: Center(
              child: ConditionalBuilder(
                condition: AppCubit.get(context).isSearching,
                builder: (context) => SearchResultsScreen(),
                fallback: (context) => SearchScreen(),
              ),
            ),
          );
        });
  }
}
