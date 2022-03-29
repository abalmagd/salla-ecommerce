import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:salla/blocs/bloc_observer.dart';
import 'package:salla/shared/local/cache_helper.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.dioInit();
  BlocOverrides.runZoned(
    () => runApp(App()),
    blocObserver: MyBlocObserver(),
  );
}
