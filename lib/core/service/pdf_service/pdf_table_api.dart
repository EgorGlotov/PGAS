import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:pgas/core/service/pdf_service/pdf_service.dart';
import 'package:pgas/data/model/event_model/event_model.dart';
import 'package:pgas/data/model/user_model/user_model.dart';




class TablePdfApi{
  static Future<File>generateTablePdf(UserModel user, List<EventModel> events) async{

    final regularTtf = await rootBundle.load('assets/font/TimesNewRomanRegular.ttf');
    final regularFont = pw.Font.ttf(regularTtf);

    final pdf = pw.Document();
    final day = DateTime.now();
    final dayFormatted = DateFormat('dd.MM.yyyy').format(day);

    final headers = ['№','Название мероприятия','Дата','Вид Деятельности*','Статус**','Уровень***','Документ****','Баллы'];
    final data = events.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final event = entry.value;
      return [
        index.toString(),
        event.eventName,
        DateFormat('dd.MM.yyyy').format(DateTime.parse(event.eventDate)),
        event.activityType,
        event.achievementStatus,
        event.achievementLevel,
        event.documentProof,
        event.points.toString(),
      ];
    }).toList();


   // final data = students.map((student) => [student.name, student.age.toString()]).toList();
    

pdf.addPage(
  pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
    margin: const pw.EdgeInsets.all(32),
    build: (pw.Context context) => [
      pw.Center(
        child: pw.Column(
          children: [
            pw.Text('РЕЕСТР', style: pw.TextStyle(fontSize: 12, font: regularFont)),
            pw.Text('(информационная карта) мероприятий, ', style: pw.TextStyle(fontSize: 12, font: regularFont)),
            pw.Text('подтверждающих наличие особых достижений студента ', style: pw.TextStyle(fontSize: 12, font: regularFont)),
            pw.Text('в одной или нескольких областях деятельности', style: pw.TextStyle(fontSize: 12, font: regularFont)),
            pw.Text('в период с 1 сентября 2023 года по 31 августа 2024 года', style: pw.TextStyle(fontSize: 12, font: regularFont)),
          ],
        ),
      ),
      pw.SizedBox(height: 40),
      pw.Text('Студент: ${user.surname} ${user.name} ${user.middleName}', style: pw.TextStyle(fontSize: 12, font: regularFont)),
      pw.Text('Группа: ${user.group}', style: pw.TextStyle(fontSize: 12, font: regularFont)),
      pw.Text('студент являлся участником следующих мероприятий:', style: pw.TextStyle(fontSize: 12, font: regularFont)),
      pw.SizedBox(height: 5),
      pw.TableHelper.fromTextArray(
        headers: headers,
        data: data,
        cellAlignment: pw.Alignment.center,
        tableWidth: pw.TableWidth.max,
        headerHeight: 20,
        cellHeight: 20,
        border: pw.TableBorder.all(width: 1),
        headerStyle: pw.TextStyle(fontSize: 12, font: regularFont),
        cellStyle: pw.TextStyle(fontSize: 12, font: regularFont),
      ),
      pw.SizedBox(height: 40),
      pw.Row(children: [
        pw.Text(dayFormatted, style: pw.TextStyle(fontSize: 12, font: regularFont)),
        pw.Spacer(),
        pw.Text(user.surname, style: pw.TextStyle(fontSize: 12, font: regularFont)),
      ]),
      pw.SizedBox(height: 40),
      pw.Text('*учебная (У), научно-исследовательская (НИ), культурно-творческая (КТ), общественная (О), спортивная (С)', style: pw.TextStyle(fontSize: 10, font: regularFont)),
      pw.Text('**международный, всероссийский, межрегиональный, региональный, вузовский, факультетский', style: pw.TextStyle(fontSize: 10, font: regularFont)),
      pw.Text('***участник, призер, победитель/организатор, волонтер/помощник организатора, автор/соавтор', style: pw.TextStyle(fontSize: 10, font: regularFont)),
      pw.Text('****сертификат, диплом, грамота, справка-подтверждение (за организацию, за помощь в организации, за участие), благодарность, публикация(с исходными данными статьи)', style: pw.TextStyle(fontSize: 10, font: regularFont)),
    ],
  ),
);

    return SaveAndOpenDocument.savePdf(name: 'table_pdf.pdf', pdf: pdf);
  }
}