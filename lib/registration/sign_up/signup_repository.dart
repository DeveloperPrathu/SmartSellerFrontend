import 'package:dio/dio.dart';
import 'package:smart_seller_frontend/constants.dart';

class SignUpRepository {
  final Dio dio = Dio();

  Future<Response> requestOtp(email, phone) async {
    final response = await dio.post(BASE_URL + "/request_otp/",data:{
      'email':email,
      'phone':phone,
    });

    return response;
  }
}