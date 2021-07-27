import 'package:cirilla/blocs/app_bloc/app_cubit.dart';
import 'package:cirilla/blocs/app_bloc/app_states.dart';
import 'package:cirilla/layout/search_layout.dart';
import 'package:cirilla/screens/categories_screen.dart';
import 'package:cirilla/screens/home_screen.dart';
import 'package:cirilla/screens/favorites_screen.dart';
import 'package:cirilla/screens/profile_screen.dart';
import 'package:cirilla/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayout extends StatelessWidget {
  final List<Widget> _screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) => Scaffold(
        // drawer: Drawer(),
        appBar: AppBar(
          title: Text(
            'Salla',
            style: TextThemes.appBarTitle(context),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  AppCubit.get(context).dbInit();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SearchLayout()));
                }),
          ],
        ),
        body: _screens[AppCubit.get(context).bottomNavIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: AppCubit.get(context).bottomNavIndex,
          onTap: (index) => AppCubit.get(context).changeBottomNavIndex(index),
          unselectedItemColor: Theme.of(context).accentColor,
          selectedItemColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
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
              icon: Icon(Icons.favorite_border_outlined),
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
