abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

//<editor-fold desc="Login">
class AuthLoginLoadingState extends AuthStates {}

class AuthLoginSuccessState extends AuthStates {}

class AuthLoginErrorState extends AuthStates {}
//</editor-fold>

//<editor-fold desc="Register">
class AuthRegisterLoadingState extends AuthStates {}

class AuthRegisterSuccessState extends AuthStates {}

class AuthRegisterErrorState extends AuthStates {}
//</editor-fold>
