// ignore_for_file: deprecated_member_use, unnecessary_string_interpolations, use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyEventCard extends StatelessWidget {
  final String imagePath;
  final String eventName;
  final String location;
  final double latitud;
  final double longitud;
  final String date;
  MyEventCard({
    Key? key,
    required this.imagePath,
    required this.eventName,
    required this.location,
    required this.latitud,
    required this.longitud,
    required this.date,
  }) : super(key: key);

  Future<String> _generateAndSavePdfUrl(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                eventName,
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8.0),
              pw.Text('Location: $location'),
              pw.SizedBox(height: 8.0),
              pw.Text('Date: ${DateTime.now().toLocal()}'),
            ],
          );
        },
      ),
    );
    final tempDir = await getTemporaryDirectory();
    final file =
        File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.pdf');

    await file.writeAsBytes(await pdf.save());

    // Encode the file path as a URL
    String pdfUrl = Uri.file(file.path).toString();
    return pdfUrl;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String pdfUrl = await _generateAndSavePdfUrl(context);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return FutureBuilder(
              future: Future.value(pdfUrl),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Center(
                    child: TicketWidget(
                      width: 350,
                      height: 500,
                      isCornerRounded: true,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eventName,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text('Name: $location'),
                          const SizedBox(height: 8.0),
                          SizedBox(
                            width: double.infinity,
                            height: 200.0,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(latitud, longitud),
                                zoom: 15.0,
                              ),
                              markers: {
                                Marker(
                                  markerId: MarkerId(eventName),
                                  position: LatLng(latitud, longitud),
                                ),
                              },
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            'Escanear entrada:',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () {
                              launch(snapshot.data.toString());
                            },
                            child: QrImageView(
                              data: '$eventName',
                              version: QrVersions.auto,
                              size: 150.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventName,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(date),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
