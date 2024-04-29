class Result<T> {
  final T? value;
  final Exception? error;

  Result._(this.value, this.error);

  factory Result.success(T value) => Result._(value, null);

  factory Result.failure(Exception error) => Result._(null, error);

  bool get isSuccess => value != null;

  bool get isFailure => error != null;

  void when({
    required void Function(T value) success,
    required void Function(Exception error) failure,
  }) {
    if (isSuccess) {
      success(value as T);
    } else {
      failure(error!);
    }
  }
}
