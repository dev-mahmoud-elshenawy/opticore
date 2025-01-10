import 'package:flutter_test/flutter_test.dart';
import 'package:opticore/opticore.dart';


void main() {
  group('OptiCore Tests', () {
    test(
        'Test stopRepeating function executes action once in specified duration',
        () {
      bool actionExecuted = false;

      // Using the stopRepeating method with a 1-second duration
      bool result = ToolsHelper.stopRepeating(
        action: () {
          actionExecuted = true;
        },
        duration: Duration(seconds: 1),
      );

      // Assert that the action was executed
      expect(result, true);
      expect(actionExecuted, true);

      // Try executing it again immediately (within 1 second)
      actionExecuted = false; // Reset flag
      result = ToolsHelper.stopRepeating(
        action: () {
          actionExecuted = true;
        },
        duration: Duration(seconds: 1),
      );

      // Assert that the action is not executed because it's within the duration
      expect(result, false);
      expect(actionExecuted, false);
    });
  });
}
