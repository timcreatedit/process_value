import 'package:meta/meta.dart';

/// {@template process_value}
/// A union type for [ProcessData], [ProcessLoading], and [ProcessError].
///
/// Meant to treat a process declaratively, as a stream of values. This concept
/// is similar to `AsyncValue` from [Riverpod](https://riverpod.dev/).
/// {@endtemplate}
sealed class ProcessValue<T> {
  /// {@macro process_value}
  const ProcessValue();
}

/// {@template process_data}
/// A value of type [T] that represents the successful completion of a process.
///
/// A [ProcessData] has value-equality with another [ProcessData] if their
/// values are equal.
/// {@endtemplate}
@immutable
class ProcessData<T> extends ProcessValue<T> {
  /// {@macro process_data}
  const ProcessData(this.value);

  /// The resulting value of the process.
  final T value;

  @override
  String toString() => 'ProcessData<$T>($value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProcessData<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// {@template process_loading}
/// The process is still running, but progress is available.
/// {@endtemplate}
@immutable
class ProcessLoading<T> extends ProcessValue<T> {
  /// {@macro process_loading}
  const ProcessLoading(this.progress)
      : assert(
          progress >= 0 && progress <= 1,
          'Progress must be between 0 and 1',
        );

  /// The progress of the process, between 0 and 1.
  final double progress;

  @override
  String toString() => 'ProcessLoading<$T>($progress)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProcessLoading<T> &&
          runtimeType == other.runtimeType &&
          progress == other.progress;

  @override
  int get hashCode => progress.hashCode;
}

/// {@template process_error}
/// The process failed with an [error] and optional [stackTrace].
/// {@endtemplate}
@immutable
class ProcessError<T> extends ProcessValue<T> {
  /// {@macro process_error}
  const ProcessError(this.error, {this.stackTrace});

  /// The error that caused the process to fail.
  final Object error;

  /// The stack trace of the error, if available.
  final StackTrace? stackTrace;

  @override
  String toString() => 'ProcessError<$T>($error)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProcessError<T> &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          stackTrace == other.stackTrace;

  @override
  int get hashCode => error.hashCode ^ stackTrace.hashCode;
}
