class Failure {
  final String error;
  final String? statusCode;

  Failure({
    required this.error,
    this.statusCode,
  });
}


class Result<T> {
  final T? data;
  final Failure? error;

  Result.success(this.data) : error = null;
  Result.failure(this.error) : data = null;

  void fold(Null Function(dynamic failure) param0, Null Function(dynamic _) param1) {}
}

