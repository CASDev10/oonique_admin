import 'package:dio/dio.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';
import '../models/authResponse.dart';
import '../models/login_input_model.dart';
import 'session_repository.dart';

class AuthRepository {
  final DioClient _dioClient;
  final SessionRepository _sessionRepository;

  final _log = logger(AuthRepository);

  AuthRepository({
    required DioClient dioClient,

    required SessionRepository sessionRepository,
  }) : _dioClient = dioClient,
       _sessionRepository = sessionRepository;
  //
  Future<AuthResponse> login(LoginInput loginInput) async {
    try {
      var response = await _dioClient.post(
        Endpoints.login,
        data: loginInput.toJson(),
      );
      AuthResponse authResponse = AuthResponse.fromJson(response.data);
      _dioClient.setToken(authResponse.data.token);
      await _sessionRepository.setLoggedIn(true);
      return authResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e, stackTrace) {
      _log.e(stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  //
  // Future<AuthResponse> signup(SignupInput signupInput) async {
  //   try {
  //     print("Request ${signupInput.toJson()}");
  //     var response = await _dioClient.post(Endpoints.signup,
  //         data: signupInput.toFormData());
  //     if (response.data['result'] == ApiResult.success) {
  //       AuthResponse authResponse = AuthResponse.fromJson(response.data);
  //       UserModel userModel = authResponse.data;
  //       await _userAccountRepository.saveUserInDb(userModel);
  //       await _sessionRepository.setToken(authResponse.token);
  //       _dioClient.setToken(authResponse.token);
  //       await _sessionRepository.setLoggedIn(true);
  //       return authResponse;
  //     }
  //     throw response.data['message'];
  //   } on DioException catch (e, stackTrace) {
  //     _log.e(e, stackTrace: stackTrace);
  //     throw ApiError.fromDioException(e);
  //   } on TypeError catch (e) {
  //     _log.e(e.stackTrace);
  //     throw ApiError(message: '$e', code: 0);
  //   } catch (e) {
  //     _log.e(e);
  //     throw ApiError(message: '$e', code: 0);
  //   }
  // }
  //
  // Future<bool> sendOtp(String email) async {
  //   print(email);
  //   try {
  //     var response = await _dioClient.post(
  //       Endpoints.sendOtp,
  //       queryParameters: {'email': email},
  //     );
  //     if (response.data['result'] == ApiResult.success) {
  //       return true;
  //     }
  //     throw response.data['message'];
  //   } on DioException catch (e, stackTrace) {
  //     _log.e(e, stackTrace: stackTrace);
  //     throw ApiError.fromDioException(e);
  //   } on TypeError catch (e) {
  //     _log.e(e.stackTrace);
  //     throw ApiError(message: '$e', code: 0);
  //   } catch (e) {
  //     _log.e(e);
  //     throw ApiError(message: '$e', code: 0);
  //   }
  // }
  //
  // Future<bool> verifyOtp(String email, String otp) async {
  //   try {
  //     var response = await _dioClient.post(
  //       Endpoints.verifyOtp,
  //       queryParameters: {'email': email, "otp": otp},
  //     );
  //     if (response.data['result'] == ApiResult.success) {
  //       return true;
  //     }
  //     print(response.data['message']);
  //
  //     throw response.data['message'];
  //   } on DioException catch (e, stackTrace) {
  //     _log.e(e, stackTrace: stackTrace);
  //     throw ApiError.fromDioException(e);
  //   } on TypeError catch (e) {
  //     _log.e(e.stackTrace);
  //     throw ApiError(message: '$e', code: 0);
  //   } catch (e) {
  //     _log.e(e);
  //     throw ApiError(message: '$e', code: 0);
  //   }
  // }
  //
  // Future<bool> updatePassword(
  //     String email, String password, String confirmPassword) async {
  //   try {
  //     var response = await _dioClient.post(
  //       Endpoints.resetPassword,
  //       queryParameters: {
  //         'email': email,
  //         "password": password,
  //         "passwordConfirm": confirmPassword
  //       },
  //     );
  //     if (response.data['result'] == ApiResult.success) {
  //       return true;
  //     }
  //     throw response.data['message'];
  //   } on DioException catch (e, stackTrace) {
  //     _log.e(e, stackTrace: stackTrace);
  //     throw ApiError.fromDioException(e);
  //   } on TypeError catch (e) {
  //     _log.e(e.stackTrace);
  //     throw ApiError(message: '$e', code: 0);
  //   } catch (e) {
  //     _log.e(e);
  //     throw ApiError(message: '$e', code: 0);
  //   }
  // }
}
