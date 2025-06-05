import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:oonique/modules/main/screens/support/models/update_support_response.dart';
import 'package:oonique/ui/widgets/helper_function.dart';

import '../../../../../constants/api_endpoints.dart';
import '../../../../../core/exceptions/api_error.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../utils/logger/logger.dart';
import '../models/all_support_response.dart';

class SupportRepository {
  final DioClient _dioClient;

  final _log = logger(SupportRepository);

  SupportRepository({required DioClient dioClient}) : _dioClient = dioClient;

  //
  Future<AllSupportResponse> allTickets({int? page = 1}) async {
    try {
      var query = {"limit": 20, "page": page};

      final token = await getToken();
      var response = await _dioClient.get(
        Endpoints.support,
        queryParameters: query,
        options: Options(headers: {'Authorization': token}),
      );
      AllSupportResponse allSupportResponse = await compute(
        allSupportResponseFromJson,
        response.data,
      );
      return allSupportResponse;
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

  Future<UpdateSupportResponse> updateTicket({
    required int supportId,
    required String status,
  }) async {
    try {
      var data = {"status": status};
      final token = await getToken();
      var response = await _dioClient.post(
        Endpoints.updateSupport(supportId),
        data: data,

        options: Options(headers: {'Authorization': token}),
      );
      UpdateSupportResponse updateSupportResponse = await compute(
        updateSupportResponseFromJson,
        response.data,
      );
      return updateSupportResponse;
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

  Future<UpdateSupportResponse> addResponse({
    required int supportId,
    required String status,
  }) async {
    try {
      var data = {"status": status};
      final token = await getToken();
      var response = await _dioClient.post(
        Endpoints.updateSupport(supportId),
        data: data,

        options: Options(headers: {'Authorization': token}),
      );
      UpdateSupportResponse updateSupportResponse = await compute(
        updateSupportResponseFromJson,
        response.data,
      );
      return updateSupportResponse;
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
}
