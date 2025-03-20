import 'package:dio/dio.dart';

/// This file contains the abstract class Failure which is the parent class of all the failures that can occur in the application.
abstract class Failure {
  final String errmessage;

  Failure(this.errmessage);
}

/// This class represents a failure that occurs due to a server error.
class ServerFailure extends Failure {
  ServerFailure(super.errmessage);
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout ');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout ');
      case DioExceptionType.badResponse:
        return ServerFailure('Response Error  ${dioError.response?.statusCode}');
      case DioExceptionType.cancel:
        return ServerFailure('Request Cancelled');
      case DioExceptionType.unknown:
        return ServerFailure('Unknown Error');
      default:
        return ServerFailure('Check your internet connection');
    }
  }
}
