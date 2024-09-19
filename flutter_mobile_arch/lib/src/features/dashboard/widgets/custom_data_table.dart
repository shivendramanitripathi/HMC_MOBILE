import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

class CustomDataSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = [];

  CustomDataSource(List<dynamic> dataList) {
    _dataGridRows = dataList.map<DataGridRow>((data) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'userId', value: data['userId']),
        DataGridCell<int>(columnName: 'id', value: data['id']),
        DataGridCell<String>(columnName: 'title', value: data['title']),
        DataGridCell<String>(columnName: 'body', value: data['body']),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        TextStyle textStyle;
        if (dataGridCell.columnName == 'title') {
          textStyle = const TextStyle(color: Colors.green, fontSize: 12);
        } else if (dataGridCell.columnName == 'body') {
          textStyle = const TextStyle(color: Colors.red, fontSize: 12);
        } else {
          textStyle = const TextStyle(color: Colors.black, fontSize: 12);
        }
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[300]!,
                width: 1.0,
              ),
            ),
          ),
          child: Text(
            dataGridCell.value.toString(),
            style: textStyle,
          ),
        );
      }).toList(),
    );
  }
}
