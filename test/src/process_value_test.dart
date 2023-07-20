// ignore_for_file: prefer_const_constructors

import 'package:process_value/process_value.dart';
import 'package:test/test.dart';

void main() {
  group("ProcessValue", () {
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

    group(".data", () {
      test("creates a ProcessData", () async {
        expect(ProcessValue.data(42), ProcessData(42));
      });
    });

    group(".loading", () {
      test("creates a ProcessLoading", () async {
        expect(ProcessValue<int>.loading(0.5), ProcessLoading<int>(0.5));
      });
    });

    group(".error", () {
      test("creates a ProcessError", () async {
        expect(ProcessValue<int>.error("oops"), ProcessError<int>("oops"));
      });
    });

    group("whenData", () {
      test("maps value correctly", () async {
        final sut = ProcessData(42);
        final result = sut.whenData((value) => value.toString());
        expect(result, ProcessData("42"));
      });
      test("returns error when mapping fails", () async {
        final sut = ProcessData("fourtytwo");
        final result = sut.whenData(int.parse);
        expect(
          result,
          // ignore: inference_failure_on_untyped_parameter
          (r) => r is ProcessError<int> && r.error is FormatException,
        );
      });
      test("forwards progress", () async {
        final sut = ProcessValue<int>.loading(0.5);
        final result = sut.whenData((value) => value.toString());
        expect(result, ProcessLoading<String>(0.5));
      });
      test("forwards error", () async {
        final sut = ProcessValue<int>.error("oops");
        final result = sut.whenData((value) => value.toString());
        // ignore: inference_failure_on_untyped_parameter
        expect(result, (r) => r is ProcessError<String> && r.error == "oops");
      });
    });
  });
  group("ProcessData", () {
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

  group("ProcessLoading", () {
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

  group("ProcessError", () {
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
