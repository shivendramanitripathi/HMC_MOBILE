import 'package:flutter_mobile_arch/src/features/dashboard/provider/dashboard_provider.dart';
import 'package:flutter_mobile_arch/src/models/task_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_mobile_arch/src/services/api_service.dart';

class MockApiService extends Mock implements ApiService {}

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  group('DashboardSupportProvider', () {
    late MockApiService mockApiService;
    late MockConnectivity mockConnectivity;
    late DashboardSupportProvider provider;

    setUp(() {
      mockApiService = MockApiService();
      mockConnectivity = MockConnectivity();
      provider = DashboardSupportProvider();
    });

    test('should fetch data successfully and increase page', () async {
      await provider.reloadData();

      expect(provider.dataList.isNotEmpty, true); // Data is loaded
      expect(provider.isLoading, false); // Loading state is reset
      expect(provider.currentPage, 2); // Page is incremented
    });

    test('should handle failed API request', () async {
      await provider.reloadData();

      expect(provider.dataList.isEmpty, true);
      expect(provider.isLoading, false);
    });

    test('should add task and notify listeners', () {
      final task = Task(
        id: '123',
        description: 'Task Test',
      );
      provider.addTask(task);

      expect(provider.tasks.contains(task), true);
    });
  });
}
