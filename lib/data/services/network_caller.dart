import 'dart:convert';
import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/presentation/state_holders/auth_controller.dart';
import 'package:cartzy/presentation/ui/screens/email_verification_screen.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkCaller {
  NetworkCaller({required this.logger,required this.authController});
  final Logger logger;
  final AuthController authController;

  Future<NetworkResponse> getRequest({
    required String url,
    String? token,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _requestLog(url, {}, {}, '');

      final Response response = await get(
        uri,
        headers: {'token': '${token ?? AuthController.accessToken}'},
      );
      if (response.statusCode == 200) {
        _responseLog(
          url,
          response.statusCode,
          response.body,
          response.headers,
          true,
        );
        final decodedBody = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodedBody,
        );
      } else {
        _responseLog(url, response.statusCode, response.body, response.headers, false,);
        if(response.statusCode==401){
          _moveToLogIn();
        }
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      _responseLog(url, -1, null, {}, false, e);
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMassage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _requestLog(url, {}, body ?? {}, '');
      final Response response = await post(uri, headers: {
          'token': '${AuthController.accessToken}',
          'content-type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        _responseLog(url, response.statusCode, response.body, response.headers, true,
        );
        final decodedBody = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodedBody,
        );
      } else {
        _responseLog(url, response.statusCode, response.body, response.headers, false,);
        if (response.statusCode == 401) {
          _moveToLogIn();
        }
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      _responseLog(url, -1, null, {}, false, e);
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMassage: e.toString(),
      );
    }
  }

  Future<void> _moveToLogIn() async {
    await authController.clearUserData();
    getx.Get.to(()=>EmailVerificationScreen());
  }

  void _requestLog(
    String url,
    Map<String, dynamic> params,
    Map<String, dynamic> body,
    String token,
  ) {
    logger.i('''
    Url:$url
    Params:$params
    Body:$body
    Token:$token
    ''');
  }

  void _responseLog(
    String url,
    int statusCode,
    dynamic responseBody,
    Map<String, dynamic> headers,
    bool isSuccess, [
    dynamic error,
  ]) {
    String massage = '''
    Url:$url
    Status Code:$statusCode
    Headers:$headers
    Response Body:$responseBody
    Error:$error
    ''';
    if (isSuccess) {
      logger.i(massage);
    } else {
      logger.e(massage);
    }
  }
}
