

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_seller_frontend/constants.dart';
import 'package:smart_seller_frontend/registration/login/login_repository.dart';
import 'package:smart_seller_frontend/registration/login/login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(LoginInitial());

  LoginRepository _repository = LoginRepository();

  void login(emai_phone, password) {
    String? email, phone;
    emit(LoginSubmitting());
    if (RegExp(EMAIL_REGEX).hasMatch(emai_phone)) {
      email = emai_phone;
    } else {
      phone = emai_phone;
    }

    _repository.login(email, phone, password)
        .then((response) {
      emit(LoginSuccess(response.data));
    }).catchError((value) {
      DioError error = value;
      if (error.response != null) {
        try {
          emit(LoginFailed(error.response!.data));
        } catch (e) {
          emit(LoginFailed(error.response!.data['detail']));
        }
      } else {
        if (error.type == DioErrorType.other) {
          emit(LoginFailed("Please check your internet connection"));
        } else {
          emit(LoginFailed(error.message));
        }
      }
    });
  }
}