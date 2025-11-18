import 'dart:io' as io; // для платформ Android/iOS
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // для kIsWeb
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import 'dart:html' as html; // Только для Web

class SaveAndOpenDocument {
  static Future<void> savePdf({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    if (kIsWeb) {
      _downloadWeb(bytes, name);
    } else {
      final file = await _saveMobile(bytes, name);
      await _openFile(file);
    }
  }

  static Future<io.File> _saveMobile(Uint8List bytes, String name) async {
    io.Directory directory;

    if (io.Platform.isAndroid) {
      final dir = await getExternalStorageDirectory();
      directory = dir ?? await getApplicationDocumentsDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final file = io.File('${directory.path}/$name');
    await file.writeAsBytes(bytes);
    debugPrint('Saved to: ${file.path}');
    return file;
  }

  static Future<void> _openFile(io.File file) async {
    try {
      await OpenFile.open(file.path);
    } catch (e) {
      debugPrint('Error opening file: $e');
    }
  }

  static void _downloadWeb(Uint8List bytes, String filename) {
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}