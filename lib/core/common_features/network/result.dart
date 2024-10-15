abstract class Result<T> {
  const Result();

  R when<R>({
    required R Function(T) success,
    required R Function(String) failure,
  });
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);

  @override
  R when<R>({
    required R Function(T) success,
    required R Function(String) failure,
  }) {
    return success(data);
  }
}

class Failure<T> extends Result<T> {
  final String message;

  const Failure(this.message);

  @override
  R when<R>({
    required R Function(T) success,
    required R Function(String) failure,
  }) {
    return failure(message);
  }
}
