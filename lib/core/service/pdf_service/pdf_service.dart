import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart'as pw;


class SaveAndOpenDocument {
  static Future<File> savePdf({
    required String name,
    required pw.Document pdf,
  }) async {
    Directory directory;
    
    if (Platform.isAndroid) {
      // Для Android получаем внешнее хранилище
      final dir = await getExternalStorageDirectory();
      directory = dir ?? await getApplicationDocumentsDirectory();
    } else {
      // Для iOS/других платформ
      directory = await getApplicationDocumentsDirectory();
    }
    
    final file = File('${directory.path}/$name');
    await file.writeAsBytes(await pdf.save());
    debugPrint('Saved to: ${file.path}');
    return file;
  }

  static Future<void> openPdf(File file) async {
    final path = file.path;
    try {
      await OpenFile.open(path);
    } catch (e) {
      debugPrint('Error opening file: $e');
    }
  }
  
}