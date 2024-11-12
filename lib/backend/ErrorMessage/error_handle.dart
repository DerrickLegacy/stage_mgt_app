class ErrorMessage {
  final String errorMessage;
  final String? error;

  ErrorMessage({required this.errorMessage, this.error});

  String get errorMessageAndError {
    if (error != null && error!.isNotEmpty) {
      return '$errorMessage: $error';
    } else {
      return errorMessage;
    }
  }
}
