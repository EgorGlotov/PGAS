import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pgas/core/service/pdf_service/pdf_service.dart';
import 'package:pgas/core/service/pdf_service/pdf_table_api.dart';

class PdfPage extends StatelessWidget{
  const PdfPage({super.key});
  static const String path = '/pdf_page ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Создать PDF документ', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: () async {
          final tablePdf = await TablePdfApi.generateTablePdf();
          SaveAndOpenDocument.openPdf(tablePdf);
        },
        child: Text('Сгенерировать PDF'), // Добавлен обязательный child
      ),
    ],
  ),
),
      bottomNavigationBar: BottomAppBar(
        color: Colors.indigo,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.save_alt, color: Colors.white),
            iconSize: 50,
            onPressed: () => Text('ahahaha'),
          ),
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            iconSize: 50,
            onPressed: () => context.go('/home_page'),
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            iconSize: 50,
            onPressed: () => context.go('/account_page'),
          ),
        ],
      ),
      ),
    );
  }
}