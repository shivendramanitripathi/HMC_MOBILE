import 'dart:developer';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'file_enum.dart';

class FileDownloader {
  Future<void> downloadFile(FileType fileType, dynamic data) async {
    switch (fileType) {
      case FileType.pdf:
        await _downloadPdf(data);
        break;
      case FileType.excel:
        await _downloadExcel(data);
        break;
      case FileType.xls:
        await _downloadXls(data);
        break;
      case FileType.xlsx:
        await _downloadXlsx(data);
        break;
    }
  }

  Future<void> _downloadPdf(dynamic data) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      build: (pw.Context context) => pw.Center(child: pw.Text(data)),
    ));

    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/file.pdf";
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    log("PDF file saved at $filePath");
  }

  Future<void> _downloadExcel(List<List<dynamic>> data) async {
    final excel = Excel.createExcel();

    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/file.xlsx";
    final file = File(filePath);
    await file.writeAsBytes(excel.encode()!);

    log("Excel file saved at $filePath");
  }

  Future<void> _downloadXls(List<List<dynamic>> data) async {}

  Future<void> _downloadXlsx(List<List<dynamic>> data) async {
    final excel = Excel.createExcel();

    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/file.xlsx";
    final file = File(filePath);
    await file.writeAsBytes(excel.encode()!);

    log("XLSX file saved at $filePath");
  }
}
