import 'package:flutter/material.dart';
import 'package:flutter_mobile_arch/src/features/dashboard/widgets/custom_data_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  testWidgets('CustomDataSource displays data in DataGrid',
      (WidgetTester tester) async {
    final dataList = [
      {'userId': 1, 'id': 1, 'title': 'Test Title 1', 'body': 'Test Body 1'},
      {'userId': 2, 'id': 2, 'title': 'Test Title 2', 'body': 'Test Body 2'},
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SfDataGrid(
            source: CustomDataSource(dataList),
            columns: [
              GridColumn(columnName: 'userId', label: const Text('User ID')),
              GridColumn(columnName: 'id', label: const Text('ID')),
              GridColumn(columnName: 'title', label: const Text('Title')),
              GridColumn(columnName: 'body', label: const Text('Body')),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Test Title 1'), findsOneWidget);
    expect(find.text('Test Body 1'), findsOneWidget);
    expect(find.text('Test Title 2'), findsOneWidget);
    expect(find.text('Test Body 2'), findsOneWidget);
  });
}
