import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/blocs/app_bloc/app_cubit.dart';
import 'package:salla/screens/auth/on_boarding_screen.dart';
import 'package:salla/shared/local/cache_helper.dart';

import 'blocs/app_bloc/app_states.dart';
import 'blocs/auth_bloc/auth_cubit.dart';
import 'config/themes.dart';
import 'layout/app_layout.dart';

class App extends StatelessWidget {
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AuthCubit()),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..getHome()
            ..getCategories()
            ..getFavorites(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppCubit.get(context).darkTheme ? darkTheme(context) : lightTheme(context),
            darkTheme: darkTheme(context),
            home: CacheHelper.isLogged() ? AppLayout() : OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
