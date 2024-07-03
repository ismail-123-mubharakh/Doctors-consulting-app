


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class BillingScreen extends StatefulWidget {
  final String name;
  final String whatsappNumber;
  final String address;
  final String location;
  final String branch;
  final List<String> treatments;
  final String totalAmount;
  final String discount;
  final String advance;
  final String balance;
  const BillingScreen({super.key, required this.name, required this.whatsappNumber, required this.address, required this.location, required this.branch, required this.treatments, required this.totalAmount, required this.discount, required this.advance, required this.balance});

  @override
  State<StatefulWidget> createState() {
   return BillingScreenState();
  }

}

class BillingScreenState extends State<BillingScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('PDF Generator')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final pdf = await generatePdf(widget.name,widget.whatsappNumber,widget.address,widget.location,widget.branch,widget.treatments,widget.totalAmount,widget.discount,widget.advance,widget.balance);
              await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
            },
            child: Text('Generate PDF'),
          ),
        ),
      ),
    );
  }
  Future<pw.Document> generatePdf(String name, String whatsappNumber, String address, String location, String branch, List<String> treatments, String totalAmount, String discount, String advance, String balance) async {
    final pdf = pw.Document();

    final image = (await rootBundle.load('assets/images/img.png')).buffer.asUint8List();
    final image2 = (await rootBundle.load('assets/images/img_3.png')).buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(pw.MemoryImage(image), width: 60, height: 60),
                  pw.Text(
                    address,
                    /*'KUMARAKOM\nCheepunkal PO, Kumarakom, Kottayam, Kerala - 686563\nemail: unknown@gmail.com\nMob: +91 9876543210\nGST No: 32ABACDEU963R1ZW',
*/                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Patient Details',
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                "$name\n$address\n$whatsappNumber",
                //'Name: Saili T\nAddress: Nadakkav, Kozhikode\nWhatsApp Number: +91 9876543210',
                style: const pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Treatment',
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                context: context,
                data:
                <List<String>>[
                  treatments
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                "$totalAmount\n$discount\n$advance\n$balance\n",
                //'Total Amount: ₹7,620\nDiscount: ₹500\nAdvance: ₹1,200\nBalance: ₹5,920',
                style: pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Thank you for choosing us\nYour well-being is our commitment, and we’re honored to assist you with your health journey.',
                style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Love,',
                style: pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Image(pw.MemoryImage(image2), width: 60, height: 60),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }
}