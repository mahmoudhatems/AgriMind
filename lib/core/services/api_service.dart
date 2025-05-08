// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class ApiService {
  final baseUrl = '';
  final Dio dio;
  ApiService({
    required this.dio,
  });

  Future<Map<String, dynamic>> get({
    required String endpoint,
  }) async {
    final response = await dio.get(
      '$baseUrl$endpoint',
    );
    return response.data;
  }
}
