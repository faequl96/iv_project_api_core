class GeneralException implements Exception {
  GeneralException(this.message);

  final String message;

  @override
  String toString() {
    return 'GeneralException: $message';
  }
}
