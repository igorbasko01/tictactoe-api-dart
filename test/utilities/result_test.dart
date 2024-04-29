import 'package:test/test.dart';
import 'package:tic_tac_toe_api/utilities/result.dart';

void main() {
  test('Result creates a success value', () {
    final result = Result.success(42);
    expect(result.isSuccess, isTrue);
    expect(result.isFailure, isFalse);
    expect(result.value, 42);
    expect(result.error, isNull);
  });

  test('Result creates a failure value', () {
    final result = Result.failure(Exception('An error occurred'));
    expect(result.isSuccess, isFalse);
    expect(result.isFailure, isTrue);
    expect(result.value, isNull);
    expect(result.error, isA<Exception>());
  });

  test('Result creates a failure value with a custom exception', () {
    final result = Result.failure(FormatException('Invalid input'));
    expect(result.isSuccess, isFalse);
    expect(result.isFailure, isTrue);
    expect(result.value, isNull);
    expect(result.error, isA<FormatException>());
  });

  test('Result handles success with when', () {
    final result = Result.success(42);
    result.when(
      success: (value) => expect(value, 42),
      failure: (error) => fail('Should not be called'),
    );
  });

  test('Result handles failure with when', () {
    final result = Result.failure(Exception('An error occurred'));
    result.when(
      success: (value) => fail('Should not be called'),
      failure: (error) => expect(error, isA<Exception>()),
    );
  });
}