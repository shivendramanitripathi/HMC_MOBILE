import 'package:flutter/material.dart';
import 'package:flutter_mobile_arch/src/features/dashboard/dashboard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MockDashboardSupportProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<dynamic> _dataList = [];

  bool get isLoading => _isLoading;
  List<dynamic> get dataList => _dataList;

  void reloadData() {
    _isLoading = true;
    notifyListeners();
  }

  void loadMoreData() {
    // Mock data loading functionality.
    _isLoading = false;
    _dataList = ['Item 1', 'Item 2'];
    notifyListeners();
  }
}

void main() {
  Widget createTestableWidget(Widget child) {
    return ChangeNotifierProvider<MockDashboardSupportProvider>(
      create: (_) => MockDashboardSupportProvider(),
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('DashboardScreen shows loading indicator while loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const DashboardScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('DashboardScreen shows data table after loading',
      (WidgetTester tester) async {
    final mockProvider = MockDashboardSupportProvider();

    // Load the widget.
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: mockProvider,
        child: const MaterialApp(home: DashboardScreen()),
      ),
    );

    mockProvider.loadMoreData();
    await tester.pump();

    expect(find.byType(SfDataGrid), findsOneWidget);
  });

  testWidgets('FloatingActionButton triggers notification logic',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const DashboardScreen()));

    expect(find.byIcon(Icons.notification_add_outlined), findsOneWidget);

    await tester.tap(find.byIcon(Icons.notification_add_outlined));
    await tester.pump();
  });
}
