import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:oonique/modules/dashboard/view/banner/models/add_banner_input.dart';
import 'package:oonique/modules/dashboard/view/banner/models/add_banner_response.dart';
import 'package:oonique/modules/dashboard/view/banner/models/banner_delete_response.dart';
import 'package:oonique/modules/dashboard/view/banner/models/filters_response.dart';
import 'package:oonique/modules/dashboard/view/banner/models/get_banners_response.dart';
import 'package:oonique/ui/widgets/helper_function.dart';

import '../../../../../constants/api_endpoints.dart';
import '../../../../../core/exceptions/api_error.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../utils/logger/logger.dart';

class BannersRepository {
  final DioClient _dioClient;

  final _log = logger(BannersRepository);

  BannersRepository({required DioClient dioClient}) : _dioClient = dioClient;

  //
  Future<GetBannerResponse> allBanners({int? page = 1}) async {
    try {
      var query = {"limit": 20, "page": page};
      final token = await getToken();
      print(token);
      var response = await _dioClient.get(
        Endpoints.getAllBanners,
        queryParameters: query,
        options: Options(headers: {'Authorization': token}),
      );
      GetBannerResponse getBannerResponse = await compute(
        getBannerResponseFromJson,
        response.data,
      );
      return getBannerResponse;
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

  Future<FiltersResponse> getCategories() async {
    try {
      final token = await getToken();
      var response = await _dioClient.get(
        Endpoints.categories,
        options: Options(headers: {'Authorization': token}),
      );
      FiltersResponse filtersResponse = await compute(
        filtersResponseFromJson,
        response.data,
      );
      return filtersResponse;
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

  Future<BannerDeleteResponse> deleteBanner(int bannerId) async {
    try {
      final token = await getToken();
      var response = await _dioClient.post(
        Endpoints.deleteBanner(bannerId),

        options: Options(headers: {'Authorization': token}),
      );
      BannerDeleteResponse bannerDeleteResponse = await compute(
        bannerDeleteResponseFromJson,
        response.data,
      );
      return bannerDeleteResponse;
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

  Future<AddBannerResponse> addUpdateBanner(AddBannerInput input) async {
    try {
      FormData toFormData() => FormData.fromMap({
        "title": input.title,
        "sub_title": input.subTitle,
        "description": input.description,
        "banner_link": input.bannerLink,
        "display_order": input.displayOrder,
        "status": input.status,
        "category": input.category,
        "image": input.file,
      });
      final token = await getToken();
      var response = await _dioClient.post(
        input.id != null
            ? Endpoints.updateBanner(input.id!)
            : Endpoints.getAllBanners,
        data: toFormData(),
        options: Options(headers: {'Authorization': token}),
      );
      AddBannerResponse addBannerResponse = await compute(
        addBannerResponseFromJson,
        response.data,
      );
      return addBannerResponse;
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
