import 'package:excel/excel.dart';
import 'dart:io';

import '../../models/job_model.dart';

Future<void> downloadExcel(List<Job> jobList) async {
  var excel = Excel.createExcel();
  final filePath =
      '/storage/emulated/0/Download/invoice_${DateTime.now().microsecondsSinceEpoch}jobs_table.xlsx';
  final output = File(filePath);
  output.writeAsBytesSync(excel.encode()!);

  print("Excel file saved at $filePath");
}
