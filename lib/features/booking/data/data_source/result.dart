class Result<T> {
  final T? data;
  final Failure? error;

  Result.success(this.data) : error = null;
  Result.failure(this.error) : data = null;
}

class Failure {
  final String error;
  final String? statusCode;

  Failure({required this.error, this.statusCode});
}
