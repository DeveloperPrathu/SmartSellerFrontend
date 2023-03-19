import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_seller_frontend/models/user_model.dart';
import 'package:smart_seller_frontend/registration/authentication/auth_repository.dart';
import 'package:smart_seller_frontend/registration/authentication/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  static String token = '';

  AuthRepository authRepository;
  final FlutterSecureStorage storage;

  AuthCubit({required this.storage, required this.authRepository}) : super(AuthInitial());

  Future<AuthState> authenticate() async {
    AuthState newsState;
    if(token.isEmpty){
      try{
        var tokenValue = await _getToken();
        if(tokenValue == null){
          newsState = LoggedOut();
          emit(newsState);
        }else{
          token = tokenValue;
          newsState = await _fetchUserData();
        }
      }catch(e){
        print(e);
        newsState = LoggedOut();
        emit(newsState);
      }
    }else{
      newsState = await _fetchUserData();
    }
    return newsState;
  }

  Future<AuthState> _fetchUserData() async {
    AuthState newState;
    try{
      var response = await authRepository.getUserData(token: token);
      newState = Authenticated(UserModel.fromJson(response.data));
      emit(newState);
    }catch(value){
      DioError error = value as DioError;
      if(error.response != null){
        newState = await removeToken();
      }else{
        if(error.type == DioErrorType.other){
          newState = AuthenticationField("Please check your internet connection!");
          emit(newState);

        }else{
          newState = AuthenticationField(error.message);
          emit(newState);

        }
      }
    }

    return newState;
  }

  void loggedIn(String tokenValue){
    emit(Authenticating());
    token = tokenValue;
    _setToken(token)
    .then((value) => _fetchUserData());
  }

  Future<AuthState> removeToken() async {
    AuthState newState;
    token = '';
    try{
      await _deleteToken();
    }catch(e){
      // nothing
    }

    newState = LoggedOut();
    emit(newState);
    return newState;
  }

  Future<void> _setToken(token) async {
    await storage.write(key: "token", value: token);
  }

  Future<String?> _getToken() async {
    String? value = await storage.read(key: "token");
    return value;
  }

  Future<void> _deleteToken() async {
    await storage.delete(key: "token");
  }
}