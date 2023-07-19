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
  });

  group(ProcessLoading, () {
    test("value equality", () async {
      expect(const ProcessLoading<int>(0.5), const ProcessLoading<int>(0.5));
    });
  });

  group(ProcessError, () {
    test("value equality", () async {
      final exception = Exception();
      expect(ProcessError<int>(exception), ProcessError<int>(exception));
    });
  });
}
