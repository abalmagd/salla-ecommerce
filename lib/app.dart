import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';
import 'package:salla/screens/auth/login_screen.dart';
import 'package:salla/shared/local/cache_helper.dart';

import 'blocs/auth_bloc/auth_cubit.dart';
import 'config/themes.dart';
import 'layout/app_layout.dart';

class App extends StatelessWidget {
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => AppCubit()
            ..getHome()
            ..getCategories()
            ..getFavorites(),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: themeNotifier,
        builder: (BuildContext context, theme, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme ? darkTheme(context) : lightTheme(context),
            home: CacheHelper.isLogged() ? AppLayout() : LoginScreen(),
          );
        },
      ),
    );
  }
}
