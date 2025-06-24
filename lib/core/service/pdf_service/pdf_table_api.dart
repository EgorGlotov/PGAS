import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:pgas/core/service/pdf_service/pdf_service.dart';

class Student{
  final String name;
  final int age;

  const Student({required this.name, required this.age});
}

class TablePdfApi{
  static Future<File>generateTablePdf() async{

    final regularTtf = await rootBundle.load('assets/font/TimesNewRomanRegular.ttf');
    final regularFont = pw.Font.ttf(regularTtf);

    final pdf = pw.Document();

    final headers = ['Имя','Возраст'];

    final students = [
      const Student(name: 'Виктор', age: 17),
      const Student(name: 'Светлан', age: 19),
      const Student(name: 'Эндрю', age: 15 ),
    ];

    final data = students.map((student) => [student.name, student.age.toString()]).toList();

    pdf.addPage(
      Page(build: (Context) => TableHelper.fromTextArray(
        data: data,
        headers: headers,
        cellAlignment: Alignment.center,
        tableWidth: TableWidth.max,
        headerHeight:150,
        cellHeight: 100,
        border: TableBorder.all(width: 5),
        headerStyle: TextStyle(fontSize: 50, font: regularFont),
        cellStyle: TextStyle(fontSize: 30, font: regularFont), 
        ))
    );

    return SaveAndOpenDocument.savePdf(name: 'table_pdf.pdf', pdf: pdf);
  }
}