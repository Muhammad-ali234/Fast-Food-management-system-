class ErrorHandler {
  static String getMessage(dynamic error) {
    if (error is Exception) {
      return error.toString().replaceAll('Exception: ', '');
    }
    return 'An unexpected error occurred';
  }

  static bool isConnectionError(dynamic error) {
    return error.toString().toLowerCase().contains('connection');
  }

  static bool isAuthenticationError(dynamic error) {
    return error.toString().toLowerCase().contains('authentication');
  }
}