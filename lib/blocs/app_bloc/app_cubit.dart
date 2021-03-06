import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/config/themes.dart';
import 'package:salla/models/category_model.dart';
import 'package:salla/models/favourites_model.dart';
import 'package:salla/models/home_model.dart';
import 'package:salla/models/search_model.dart';
import 'package:salla/models/user_model.dart';
import 'package:salla/screens/favorites_screen.dart';
import 'package:salla/screens/home_screen.dart';
import 'package:salla/screens/search_results_screen.dart';
import 'package:salla/shared/local/cache_helper.dart';
import 'package:salla/shared/local/sqflite_helper.dart';
import 'package:salla/shared/network/remote/api_end_points.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);
  User user = User.fromJson(jsonDecode(CacheHelper.getData(key: 'userData')));

  int bottomNavIndex = 0;
  bool isSearching = false;
  bool darkTheme = CacheHelper.getData(key: 'theme') ?? false;
  Search searchResults;
  List<Map> searchHistory = [];
  String productImage;
  Map<Type, bool> isList = {
    HomeScreen: false,
    FavoritesScreen: false,
    SearchResultsScreen: false,
  };
  Home home;
  Categories categories;
  Favorites favorites;
  Map<int, bool> favoriteList = {};

  void changeBottomNavIndex(int index) {
    bottomNavIndex = index;
    emit(AppBottomNavChangedState());
  }

  void changeTheme() {
    darkTheme = !darkTheme;
    themeNotifier.value = darkTheme;
    CacheHelper.setData(key: 'theme', value: darkTheme);
    debugPrint(darkTheme.toString());
    emit(AppChangeThemeState());
  }

  void changeView(Type widget, bool list) {
    isList[widget] = list;
    emit(AppChangeViewState());
  }

  void changeProductViewedImage({@required String image}) {
    productImage = image;
    emit(AppProductViewImageChangedState());
  }

  void dbInit() {
    SqfliteHelper.dbInit().then((value) {
      emit(AppInitDatabaseSuccessState());
      dbGet();
    }).catchError((error) {
      debugPrint(error);
      emit(AppInitDatabaseErrorState());
    });
  }

  void dbGet() {
    emit(AppGetDatabaseLoadingState());
    SqfliteHelper.dbGet().then((value) {
      searchHistory = value;
      emit(AppGetDatabaseSuccessState());
    }).catchError((error) {
      print(error);
      emit(AppGetDatabaseErrorState());
    });
  }

  void dbInsert(String query) {
    bool repeated = false;
    searchHistory.forEach((element) {
      if (element['query'] == query) repeated = true;
    });
    if (!repeated) {
      SqfliteHelper.dbInsert(query).then((_) {
        dbGet();
        emit(AppInsertDatabaseSuccessState());
      }).catchError((error) {
        print(error);
        emit(AppInsertDatabaseErrorState());
      });
    }
  }

  void dbDelete(int id) {
    SqfliteHelper.dbDelete(id).then((value) {
      emit(AppDeleteDatabaseSuccessState());
      debugPrint('$value Rows were deleted');
      dbGet();
    }).catchError((error) {
      emit(AppDeleteDatabaseErrorState());
    });
  }

  void dbClear() async {
    SqfliteHelper.dbClear().then((value) async {
      dbGet();
      debugPrint('Database cleared: $value');
      emit(AppDeleteDatabaseSuccessState());
    }).catchError((error) {
      emit(AppDeleteDatabaseErrorState());
    });
  }

  void getSearch(String query) {
    emit(SearchLoadingState());
    isSearching = true;
    debugPrint('Query: $query');
    DioHelper.post(
      url: SEARCH,
      data: {
        'text': '$query',
      },
      token: user.data.token,
    ).then((response) {
      searchResults = Search.fromJson(response.data);
      if (searchResults.status) {
        searchResults.data.data.forEach((element) {
          debugPrint('Search Item: ${element.name}');
        });
        dbInsert(query);
        emit(SearchLoadingSuccessState());
      }
    }).catchError((error) {
      debugPrint('Error getting search results: $error');
      emit(SearchLoadingErrorState());
    });
  }

  void getHome() {
    emit(AppGetHomeDataLoadingState());
    DioHelper.get(url: HOME, token: user.data.token).then((value) {
      home = Home.fromJson(value.data);
      if (home.status) {
        fillFavoritesList();
        debugPrint('Favorites: {$favoriteList}');
        emit(AppGetHomeDataSuccessState());
      }
    }).catchError((error) {
      emit(AppGetHomeDataErrorState());
      print('Getting Home Data Failed, Error: $error');
    });
  }

  void fillFavoritesList() {
    home.data.products.forEach((element) {
      favoriteList.addAll({
        element.id: element.inFavorites,
      });
    });
  }

  void getCategories() {
    emit(AppGetCategoryDataLoadingState());
    DioHelper.get(url: CATEGORIES).then((value) {
      categories = Categories.fromJson(value.data);
      if (categories.status) emit(AppGetCategoryDataSuccessState());
    }).catchError((error) {
      emit(AppGetCategoryDataErrorState());
      print('Getting Categories Data Failed, Error: ${error.toString()}');
    });
  }

  void getFavorites() {
    DioHelper.get(url: FAVORITES, token: user.data.token).then((value) {
      if (value.data['status']) {
        favorites = Favorites.fromJson(value.data);
        debugPrint('Favorites Success, Status Code: ${value.statusCode}');
        debugPrint('Favorites Length: ${favorites.data.total}');
        emit(AppGetFavoritesSuccessState());
      } else {
        debugPrint('Favorites Error, Status Code: ${value.statusCode} ${value.statusMessage}');
        emit(AppGetFavoritesErrorState());
      }
    }).catchError((error) {
      debugPrint('Favorites Error: $error');
      emit(AppGetFavoritesErrorState());
    });
  }

  void changeFavorite(int id) {
    favoriteList[id] = !favoriteList[id];
    emit(AppChangeFavoritesLoadingState());

    DioHelper.post(
      url: FAVORITES,
      data: {'product_id': id},
      token: user.data.token,
    ).then((value) {
      if (value.data['status']) {
        getFavorites();
        emit(AppChangeFavoritesSuccessState());
      } else {
        favoriteList[id] = !favoriteList[id];
        debugPrint(value.data);
        emit(AppChangeFavoritesErrorState());
      }
    }).catchError((error) {
      favoriteList[id] = !favoriteList[id];
      debugPrint('Error editing favorites: $error');
      emit(AppChangeFavoritesErrorState());
    });
  }

  void changeData({String name, String phone, String email}) {
    emit(AppProfileChangeDataLoadingState());
    DioHelper.put(
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },
      token: user.data.token,
      url: UPDATE_PROFILE,
    ).then((value) {
      if (value.data['status']) {
        debugPrint('${value.data['status']}, ${value.data['message']}');
        user = User.fromJson(value.data);
        CacheHelper.setData(key: 'userData', value: jsonEncode(value.data));
        debugPrint(value.data['message']);
        emit(AppProfileChangeDataSuccessState());
      } else {
        debugPrint('${value.data['status']}, ${value.data['message']}');
      }
    }).catchError((error) {
      print('Error changing data: $error');
      emit(AppProfileChangeDataErrorState());
    });
  }

  Future<bool> logOut() async {
    return await DioHelper.post(
      token: user.data.token,
      url: LOGOUT,
    ).then((value) {
      if (value.data['status']) {
        debugPrint('${value.data['status']} => ${value.data['message']}');
        CacheHelper.sharedPreferences.remove('userData');
        emit(AppLogOutSuccessState());
        return true;
      } else {
        debugPrint('${value.data['status']} ${value.data['message']}');
        emit(AppLogOutErrorState());
        return false;
      }
    }).catchError((error) {
      debugPrint('Error logging out: $error');
      emit(AppLogOutErrorState());
      return false;
    });
  }
}
