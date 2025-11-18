import 'dart:io' as io;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class SaveAndOpenDocument {
  static Future<void> savePdf({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();
    final directory = await getApplicationDocumentsDirectory();
    final file = io.File('${directory.path}/$name');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }
}