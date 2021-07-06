import 'package:bloc/bloc.dart';
import 'package:cirilla/models/category_model.dart';
import 'package:cirilla/models/home_model.dart';
import 'package:cirilla/shared/network/remote/api_end_points.dart';
import 'package:cirilla/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int bottomNavIndex = 0;
  void changeBottomNavIndex(int index) {
    bottomNavIndex = index;
    emit(AppBottomNavChangedState());
  }

  Home home;
  void getHome() {
    emit(AppGetHomeDataLoadingState());
    DioHelper.get(url: HOME).then((value) {
      if(value.data['status']){
        home = Home.fromJson(value.data);
        emit(AppGetHomeDataSuccessState());
      }
    }).catchError((error) {
      emit(AppGetHomeDataErrorState());
      print('Getting Home Data Failed, Error: ${error.toString()}');
    });
  }

  Categories categories;
  void getCategories() {
    emit(AppGetCategoryDataLoadingState());
    DioHelper.get(url: CATEGORIES).then((value) {
      if(value.data['status']){
        categories = Categories.fromJson(value.data);
        emit(AppGetCategoryDataSuccessState());
      }
    }).catchError((error) {
      emit(AppGetCategoryDataErrorState());
      print('Getting Categories Data Failed, Error: ${error.toString()}');
    });
  }
}
