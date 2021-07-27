import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cirilla/models/user_model.dart';
import 'package:cirilla/shared/local/cache_helper.dart';
import 'package:cirilla/shared/network/remote/api_end_points.dart';
import 'package:cirilla/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  User user;

  Future<bool> logIn({
    @required String email,
    @required String password,
  }) async {
    emit(AuthLoginLoadingState());
    await DioHelper.post(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      user = User.fromJson(value.data);
      if (user.status) {
        CacheHelper.setData(key: 'userData', value: jsonEncode(value.data));
        debugPrint('Success, Status Code: ${value.statusCode.toString()}');
        debugPrint('Response: ${user.message}');
        debugPrint('Name: ${user.data.name}');
        debugPrint('Email: ${user.data.email}');
        debugPrint('Token: ${user.data.token}');
        emit(AuthLoginSuccessState());
      } else {
        debugPrint('Failed, Status Code: ${value.statusCode}');
        debugPrint('Response: ${user.message}');
        emit(AuthLoginErrorState());
      }
    }).catchError((error) {
      debugPrint('Error logging in: $error');
      emit(AuthLoginErrorState());
    });
    return user.status;
  }

  Future<bool> register({
    @required String name,
    @required String phone,
    @required String email,
    @required String password,
  }) async {
    emit(AuthRegisterLoadingState());
    await DioHelper.post(
      url: REGISTER,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      },
    ).then((value) {
      user = User.fromJson(value.data);
      if (user.status) {
        CacheHelper.setData(key: 'userData', value: jsonEncode(value.data));
        debugPrint('Success, Status Code: ${value.statusCode}');
        debugPrint('Response: ${user.message}');
        debugPrint('Name: ${user.data.name}');
        debugPrint('Email: ${user.data.email}');
        debugPrint('Token: ${user.data.token}');
        emit(AuthRegisterSuccessState());
      } else {
        debugPrint('Failed, Status Code: ${value.statusCode}');
        debugPrint('Response: ${user.message}');
        emit(AuthRegisterErrorState());
      }
    }).catchError((error) {
      debugPrint('Error registering: $error');
      emit(AuthRegisterErrorState());
    });
    return user.status;
  }
}
