import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../models/job_model.dart';

Future<void> downloadPdf(BuildContext context, List<Job> jobList) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Table.fromTextArray(
          headers: ['Title', 'Icon'],
          data: jobList.map((job) => [job.title, job.icon.toString()]).toList(),
        );
      },
    ),
  );

  final filePath =
      '/storage/emulated/0/Download/invoice_${DateTime.now().microsecondsSinceEpoch}jobs_table.pdf';

  final output = File(filePath);
  await output.writeAsBytes(await pdf.save());

  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}
