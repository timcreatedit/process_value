// ignore_for_file: prefer_const_constructors

import 'package:process_value/process_value.dart';
import 'package:test/test.dart';

void main() {
  group(ProcessValue, () {
    test("sealed union has three types", () async {
      // This test won't compile if the shape of the union changes.
      const ProcessValue<int> sut = ProcessData(42);
      switch (sut) {
        case ProcessData():
          break;
        case ProcessLoading():
          break;
        case ProcessError():
          break;
      }
      expect(true, true);
    });
  });
  group(ProcessData, () {
    test("value equality", () async {
      expect(const ProcessData(42), const ProcessData(42));
      expect(const ProcessData(42), isNot(const ProcessData(43)));
    });

    test("toString", () async {
      expect(const ProcessData(42).toString(), "ProcessData<int>(42)");
    });

    test("hashCode", () async {
      expect(const ProcessData(42).hashCode, const ProcessData(42).hashCode);
    });
  });

  group(ProcessLoading, () {
    test("value equality", () async {
      expect(ProcessLoading<int>(0.5), ProcessLoading<int>(0.5));
    });

    test("toString", () async {
      expect(
        const ProcessLoading<int>(0.5).toString(),
        "ProcessLoading<int>(0.5)",
      );
    });

    test("hashCode", () async {
      expect(
        const ProcessLoading<int>(0.5).hashCode,
        const ProcessLoading<int>(0.5).hashCode,
      );
    });
  });

  group(ProcessError, () {
    test("value equality", () async {
      final exception = Exception();
      expect(ProcessError<int>(exception), ProcessError<int>(exception));
    });

    test("toString", () async {
      final exception = Exception();
      expect(
        ProcessError<int>(exception).toString(),
        "ProcessError<int>($exception)",
      );
    });

    test("hashCode", () async {
      final exception = Exception();
      expect(
        ProcessError<int>(exception).hashCode,
        ProcessError<int>(exception).hashCode,
      );
    });
  });
}
