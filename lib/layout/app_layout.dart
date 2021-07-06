import 'package:cirilla/blocs/app_bloc/app_cubit.dart';
import 'package:cirilla/blocs/app_bloc/app_states.dart';
import 'package:cirilla/screens/categories_screen.dart';
import 'package:cirilla/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayout extends StatelessWidget {
  final List<Widget> _screens = [
    HomeScreen(),
    CategoriesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) => Scaffold(
        drawer: AppCubit.get(context).bottomNavIndex == 0 ? Drawer() : null,
        appBar: AppBar(
          title: Text('Cirilla'),
          centerTitle: true,
        ),
        body: _screens[AppCubit.get(context).bottomNavIndex],
        bottomNavigationBar: BottomNavigationBar(
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
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              label: 'Wishlist',
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
