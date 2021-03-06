import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';
import 'package:salla/blocs/app_bloc/app_states.dart';
import 'package:salla/config/themes.dart';
import 'package:salla/layout/search_layout.dart';
import 'package:salla/screens/categories_screen.dart';
import 'package:salla/screens/favorites_screen.dart';
import 'package:salla/screens/home_screen.dart';
import 'package:salla/screens/profile_screen.dart';

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
      builder: (BuildContext context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      cubit.changeBottomNavIndex(3);
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 3, color: Theme.of(context).accentColor),
                          ),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(cubit.user.data.image),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(cubit.user.data.name),
                              Text(cubit.user.data.email),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    cubit.changeBottomNavIndex(0);
                  },
                  title: Text('Home'),
                  leading: Icon(
                    Icons.home_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    cubit.changeBottomNavIndex(1);
                  },
                  title: Text('Categories'),
                  leading: Icon(
                    Icons.apps,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    cubit.changeBottomNavIndex(2);
                  },
                  title: Text('Favorites'),
                  leading: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Icon(
                        Icons.favorite_border_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      Visibility(
                        visible: cubit.favoriteList.values.contains(true),
                        /*cubit
                      .favorites.data.data.length >= 1,*/
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).accentColor,
                          radius: 4,
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: themeNotifier,
                  builder: (BuildContext context, theme, Widget child) {
                    return ListTile(
                      title: Text('Theme Mode'),
                      leading: theme
                          ? Icon(Icons.dark_mode, color: Colors.white)
                          : Icon(Icons.dark_mode, color: Colors.black),
                      trailing: Switch(
                        value: theme,
                        onChanged: (_) => cubit.changeTheme(),
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    );
                  },
                ),
                Spacer(),
                Text(
                  '@C Salla',
                )
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(
              'Salla',
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    cubit.emit(SearchScreenState());
                    cubit.dbInit();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchLayout()));
                  }),
            ],
          ),
          body: _screens[cubit.bottomNavIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.bottomNavIndex,
            onTap: (index) => cubit.changeBottomNavIndex(index),
            // unselectedItemColor: Theme.of(context).accentColor,
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
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).accentColor,
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
        );
      },
    );
  }
}
