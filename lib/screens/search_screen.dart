import 'package:flutter/material.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';

class SearchScreen extends StatelessWidget {
  final Function fn;

  const SearchScreen({this.fn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            child: Container(),
          ),
          Row(
            children: [
              Text(
                'Search History',
              ),
              Spacer(),
              TextButton(
                child: Text(
                  'Clear All',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                onPressed: () {
                  AppCubit.get(context).dbClear();
                },
              ),
            ],
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => HistoryBuilder(
                textOnPressed: () {
                  fn(AppCubit.get(context).searchHistory[index]['query'].toString());
                  AppCubit.get(context)
                      .getSearch(AppCubit.get(context).searchHistory[index]['query'].toString());
                  AppCubit.get(context).isSearching = true;
                },
                buttonOnPressed: () {
                  AppCubit.get(context)
                      .dbDelete((AppCubit.get(context).searchHistory[index]['id']));
                },
                index: index,
              ),
              separatorBuilder: (context, index) => Divider(
                thickness: 0.2,
              ),
              itemCount: AppCubit.get(context).searchHistory.length,
            ),
          ),
        ],
      ),
    );
    /*newsBuilder(
          list: AppCubit.get(context).searchResults,
        ));*/
  }
}


class HistoryBuilder extends StatelessWidget {
  final Function() textOnPressed;
  final Function() buttonOnPressed;
  final int index;

  const HistoryBuilder({
    Key key,
    this.textOnPressed,
    this.buttonOnPressed,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              child: InkWell(
                onTap: textOnPressed,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppCubit.get(context).searchHistory[index]['query'].toString(),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
            onPressed: buttonOnPressed,
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}
