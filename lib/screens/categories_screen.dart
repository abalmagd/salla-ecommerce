import 'package:cirilla/blocs/app_bloc/app_cubit.dart';
import 'package:cirilla/blocs/app_bloc/app_states.dart';
import 'package:cirilla/models/category_model.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isList = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: AppCubit.get(context).categories != null,
            builder: (context) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.list_alt),
                      color: isList == true ? Colors.blue : Colors.grey,
                      onPressed: () {
                        setState(() {
                          isList = true;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.grid_view),
                      color: isList == false ? Colors.blue : Colors.grey,
                      onPressed: () {
                        setState(() {
                          isList = false;
                        });
                      },
                    ),
                  ],
                ),
                isList == true
                    ? Expanded(
                        child: _listBuilder(
                            categories: AppCubit.get(context).categories.data),
                      )
                    : Expanded(
                        child: _gridBuilder(
                            categories: AppCubit.get(context).categories.data),
                      ),
              ],
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget _listBuilder({@required CategoryData categories}) =>
      ListView.separated(
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) => ListTile(
          leading: Image(
            width: 75,
            image: NetworkImage(categories.data[index].image),
          ),
          title: Text(
            categories.data[index].name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
          onTap: () {},
        ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: categories.total,
      );

  Widget _gridBuilder({@required CategoryData categories}) => GridView.count(
        padding: EdgeInsets.all(8),
        childAspectRatio: 1.0,
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(
          categories.total,
          (index) => _gridLayout(
            categories: categories,
            index: index,
          ),
        ),
      );

  Widget _gridLayout({
    @required CategoryData categories,
    @required int index,
  }) {
    return Container(
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
        children: [
          Expanded(
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(categories.data[index].image),
            ),
          ),
          Text(
            categories.data[index].name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
