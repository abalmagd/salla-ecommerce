abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppBottomNavChangedState extends AppStates {}

class AppChangeViewState extends AppStates {}

class AppProductViewImageChangedState extends AppStates {}

class AppChangeThemeState extends AppStates {}

//<editor-fold desc="Getting Data">
// Home
class AppGetHomeDataLoadingState extends AppStates {}

class AppGetHomeDataSuccessState extends AppStates {}

class AppGetHomeDataErrorState extends AppStates {}

// Categories
class AppGetCategoryDataLoadingState extends AppStates {}

class AppGetCategoryDataSuccessState extends AppStates {}

class AppGetCategoryDataErrorState extends AppStates {}

// Favorites
class AppGetFavoritesLoadingState extends AppStates {}

class AppGetFavoritesSuccessState extends AppStates {}

class AppGetFavoritesErrorState extends AppStates {}
//</editor-fold>

//<editor-fold desc="Database">
class AppInitDatabaseSuccessState extends AppStates {}

class AppInitDatabaseErrorState extends AppStates {}

class AppGetDatabaseLoadingState extends AppStates {}

class AppGetDatabaseSuccessState extends AppStates {}

class AppGetDatabaseErrorState extends AppStates {}

class AppInsertDatabaseSuccessState extends AppStates {}

class AppInsertDatabaseErrorState extends AppStates {}

class AppDeleteDatabaseSuccessState extends AppStates {}

class AppDeleteDatabaseErrorState extends AppStates {}
//</editor-fold>

//<editor-fold desc="SearchStates">
class SearchScreenState extends AppStates {}

class SearchLoadingState extends AppStates {}

class SearchLoadingSuccessState extends AppStates {}

class SearchLoadingErrorState extends AppStates {}
//</editor-fold>

//<editor-fold desc="Editing Favorites">
class AppChangeFavoritesLoadingState extends AppStates {}

class AppChangeFavoritesSuccessState extends AppStates {}

class AppChangeFavoritesErrorState extends AppStates {}
//</editor-fold>

//<editor-fold desc="Profile Screen">
class AppLogOutSuccessState extends AppStates {}

class AppLogOutErrorState extends AppStates {}

class AppProfileChangeDataLoadingState extends AppStates {}

class AppProfileChangeDataSuccessState extends AppStates {}

class AppProfileChangeDataErrorState extends AppStates {}
//</editor-fold>