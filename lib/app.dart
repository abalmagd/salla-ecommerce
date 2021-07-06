import 'package:cirilla/blocs/app_bloc/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/themes.dart';
import 'layout/app_layout.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getHome()
        ..getCategories(),
      lazy: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(context),
        darkTheme: darkTheme(context),
        home: AppLayout(),
      ),
    );
  }
}
