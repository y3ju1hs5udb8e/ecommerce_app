import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String baseUrl = "https://api.escuelajs.co/api";
const Map<String, dynamic> defaultHeader = {
  'Content-Type': 'application/json',
};

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = defaultHeader;
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
  }

  //dio getter
  Dio get dio => _dio;
}
