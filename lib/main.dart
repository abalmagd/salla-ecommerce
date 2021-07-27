import 'package:bloc/bloc.dart';
import 'package:cirilla/shared/local/cache_helper.dart';
import 'package:cirilla/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'blocs/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.dioInit();
  runApp(App());
  }
