class Result<T> {
  final T? value;
  final Exception? error;

  Result._(this.value, this.error);

  factory Result.success(T value) => Result._(value, null);

  factory Result.failure(Exception error) => Result._(null, error);

  bool get isSuccess => value != null;

  bool get isFailure => error != null;

  R when<R>({
    required R Function(T value) success,
    required R Function(Exception error) failure,
  }) {
    if (isSuccess) {
      return success(value as T);
    } else {
      return failure(error!);
    }
  }
}
