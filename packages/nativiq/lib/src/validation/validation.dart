import 'package:nativiq/src/failures/failure.dart';
import 'package:nativiq/src/result/result.dart';

/// Validates a value and returns it unchanged when valid.
typedef Validator<T> = Result<T> Function(T value);

/// Reusable, code-generation-free validators.
abstract final class Validators {
  /// Requires a non-null value.
  static Validator<T?> required<T>({
    String message = 'This value is required.',
  }) {
    return (value) => value == null
        ? Result.failure(ValidationFailure(message: message))
        : Result.success(value);
  }

  /// Requires a non-empty string after trimming whitespace.
  static Validator<String> nonEmpty({
    String message = 'This value cannot be empty.',
  }) {
    return (value) => value.trim().isEmpty
        ? Result.failure(ValidationFailure(message: message))
        : Result.success(value);
  }

  /// Requires a string length within the inclusive bounds.
  static Validator<String> length({
    int? min,
    int? max,
    String message = 'This value has an invalid length.',
  }) {
    assert(min == null || min >= 0, 'min must not be negative');
    assert(max == null || max >= 0, 'max must not be negative');
    assert(min == null || max == null || min <= max, 'min must not exceed max');
    return (value) {
      final isTooShort = min != null && value.length < min;
      final isTooLong = max != null && value.length > max;
      return isTooShort || isTooLong
          ? Result.failure(ValidationFailure(message: message))
          : Result.success(value);
    };
  }

  /// Requires a pragmatic, application-level email address shape.
  static Validator<String> email({
    String message = 'Enter a valid email address.',
  }) {
    final pattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return (value) => pattern.hasMatch(value)
        ? Result.success(value)
        : Result.failure(ValidationFailure(message: message));
  }

  /// Applies validators in order and returns the first failure.
  static Validator<T> all<T>(Iterable<Validator<T>> validators) {
    final frozen = List<Validator<T>>.unmodifiable(validators);
    return (value) {
      for (final validator in frozen) {
        final result = validator(value);
        if (result case Failed<T>()) return result;
      }
      return Result.success(value);
    };
  }
}
