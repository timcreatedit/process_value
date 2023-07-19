# Process Value
[![License: MIT][license_badge]][license_link]

A declarative representation of a process.
Meant to treat a process declaratively, as a stream of values. 
This concept is similar to `AsyncValue` from [Riverpod](https://riverpod.dev/) but with a much more stripped-down implementation.

## Installation 💻

**❗ In order to start using Process Value you must have the [Dart SDK][dart_install_link] installed on your machine.**

Add `process_value` to your `pubspec.yaml`:

```yaml
dependencies:
  process_value:
```

Install it:

```sh
dart pub get
```

---

## Usage

```dart
Stream<ProcessValue<int>> loadMyInteger() async* {
  yield ProcessValue.loading(0);
  await Future.delayed(const Duration(seconds: 1));
  yield ProcessValue.loading(0.5);
  await Future.delayed(const Duration(seconds: 1));
  yield ProcessValue.loading(0.5);
  yield ProcessValue.data(42);
}
```

[dart_install_link]: https://dart.dev/get-dart
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT

