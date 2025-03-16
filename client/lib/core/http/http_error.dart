class HttpError {
  final String errorMessage;

  HttpError([this.errorMessage = "Something went wrong!"]);

  @override
  String toString() => 'HttpError(errorMessage: $errorMessage)';
}
