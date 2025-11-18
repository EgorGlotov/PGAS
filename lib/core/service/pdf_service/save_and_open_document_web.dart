import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;

class SaveAndOpenDocument {
  static Future<void> savePdf({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', name)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}