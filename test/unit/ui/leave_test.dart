import 'package:flutter_test/flutter_test.dart';
import 'package:hr_self_service/src/ui/leave/leave_state.dart';

void main() {
  group('LeaveState Tests', () {
    test('correctly calculate number of leave days', () {
      // Arrange
      final startDate1 = DateTime(2025, 10, 1);
      final endDate1 = DateTime(2025, 10, 1);

      final startDate2 = DateTime(2025, 10, 5);
      final endDate2 = DateTime(2025, 10, 10);

      final startDate3 = DateTime(2025, 10, 29);
      final endDate3 = DateTime(2025, 11, 3);

      final startDate4 = DateTime(2025, 10, 1);
      final endDate4 = DateTime(2026, 9, 29);

      // Act
      final state1 = LeaveState(
        startDate: startDate1,
        endDate: endDate1
      );
      final state2 = state1.copy(
        startDate: startDate2,
        endDate: endDate2
      );
      final state3 = state2.copy(
        startDate: startDate3,
        endDate: endDate3
      );
      final state4 = state3.copy(
        startDate: startDate4,
        endDate: endDate4
      );

      // Assert
      expect(state1.numberOfDays, 1);
      expect(state2.numberOfDays, 5);
      expect(state3.numberOfDays, 4);
      expect(state4.numberOfDays, 260);
    });
  });
}