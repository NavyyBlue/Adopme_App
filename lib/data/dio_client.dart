import 'package:dio/dio.dart';
import 'package:adopme_frontend/services/auth_service.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final idToken = AuthService.to.getIdToken();
        if (idToken != null) {
          options.headers['Authorization'] = 'Bearer $idToken';
        }
        return handler.next(options);
      },
      onError: (DioError e, handler) {
        return handler.next(e);
      },  
      onResponse: (response, handler) {
        return handler.next(response);
      },
    ));
  }

  Dio get dio => _dio;
}