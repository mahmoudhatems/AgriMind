class CustomException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  CustomException(this.message, {this.stackTrace});
  @override
  String toString() {
    return 'CustomException: $message\nStackTrace: $stackTrace';
  }}