import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';
import 'package:salla/blocs/app_bloc/app_states.dart';
import 'package:salla/screens/search_results_screen.dart';
import 'package:salla/screens/search_screen.dart';
import 'package:salla/shared/local/sqflite_helper.dart';

class SearchLayout extends StatefulWidget {
  final String query;

  SearchLayout({Key key, this.query}) : super(key: key);

  @override
  _SearchLayoutState createState() => _SearchLayoutState();
}

class _SearchLayoutState extends State<SearchLayout> {
  final FocusNode _node = FocusNode();
  TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    SqfliteHelper.dbClose();
  }

  @override
  Widget build(BuildContext context) {
    searchController.value = TextEditingValue(text: widget.query ?? '');
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 30,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  AppCubit.get(context).searchResults = null;
                  AppCubit.get(context).isSearching = false;
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
            body: ConditionalBuilder(
              condition: AppCubit.get(context).isSearching,
              builder: (context) => SearchResultsScreen(),
              fallback: (context) => SearchScreen(
                fn: (String query) {
                  searchController.text = query;
                },
              ),
            ),
          );
        });
  }
}
