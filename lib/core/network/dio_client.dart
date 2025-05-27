import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import '../../config/environment.dart';

class DioClient extends DioForBrowser {
  final Environment _environment;
  String? _locale;

  String? _authToken;

  void setToken(String token) {
    _authToken = token;
  }

  void setLocale(String locale) {
    _locale = locale;
  }

  DioClient({required Environment environment}) : _environment = environment {
    options = BaseOptions(
      baseUrl: _environment.baseUrl,
      responseType: ResponseType.json,
    );
    interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        options.headers.putIfAbsent('Accept-Language', () => _locale);
        if (_authToken != null) {
          options.headers
              .putIfAbsent('Authorization', () => 'Bearer $_authToken');
        }
        return handler.next(options);
      }),
    );
    interceptors.add(LogInterceptor(
      request: false,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
    ));
  }
}
