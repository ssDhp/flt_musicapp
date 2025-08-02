class AppFailure {
  final String errorMessage;
  AppFailure([this.errorMessage = "An unexpected error occured!"]);

  @override
  String toString() => 'Failure(message:$errorMessage)';
}
