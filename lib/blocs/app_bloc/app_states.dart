abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppBottomNavChangedState extends AppStates {}

//<editor-fold desc="Getting Data">
// Home Data
class AppGetHomeDataLoadingState extends AppStates {}

class AppGetHomeDataSuccessState extends AppStates {}

class AppGetHomeDataErrorState extends AppStates {}

// Category Data
class AppGetCategoryDataLoadingState extends AppStates {}

class AppGetCategoryDataSuccessState extends AppStates {}

class AppGetCategoryDataErrorState extends AppStates {}
//</editor-fold>