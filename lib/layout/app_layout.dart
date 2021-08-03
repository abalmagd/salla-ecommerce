import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';
import 'package:salla/blocs/app_bloc/app_states.dart';
import 'package:salla/layout/search_layout.dart';
import 'package:salla/screens/categories_screen.dart';
import 'package:salla/screens/favorites_screen.dart';
import 'package:salla/screens/home_screen.dart';
import 'package:salla/screens/profile_screen.dart';
import 'package:salla/shared/styles/text.dart';

class AppLayout extends StatelessWidget {
  final List<Widget> _screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) => Scaffold(
        backgroundColor: cubit.bottomNavIndex == 0
            ? Colors.grey[300]
            : Theme.of(context).scaffoldBackgroundColor,
        drawer: Drawer(),
        appBar: AppBar(
          title: Text(
            'Salla',
            style: TextThemes.appBarTitle(context),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  cubit.emit(SearchScreenState());
                  cubit.dbInit();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchLayout()));
                }),
          ],
        ),
        body: _screens[cubit.bottomNavIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: cubit.bottomNavIndex,
          onTap: (index) => cubit.changeBottomNavIndex(index),
          unselectedItemColor: Theme.of(context).accentColor,
          selectedItemColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                alignment: Alignment.topRight,
                children: [
                  Icon(Icons.favorite_border_outlined),
                  Visibility(
                    visible: cubit.favoriteList.values.contains(true),
                    /*cubit
                      .favorites.data.data.length >= 1,*/
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 4,
                    ),
                  ),
                ],
              ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Me',
            ),
          ],
        ),
      ),
    );
  }
}
