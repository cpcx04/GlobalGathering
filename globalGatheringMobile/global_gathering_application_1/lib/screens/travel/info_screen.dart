import 'package:flutter/material.dart';
import 'package:global_gathering_application_1/screens/book/book_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInfoWindowContent extends StatelessWidget {
  final String eventName;
  final String eventPrice;
  final String imageUrl;
  final String descripcion;
  final String date;
  final String id;

  const CustomInfoWindowContent({
    required this.eventName,
    required this.eventPrice,
    required this.imageUrl,
    required this.descripcion,
    required this.date,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius:
              BorderRadius.circular(10.0), // Ajusta según sea necesario
          child: Image.network(
            imageUrl,
            height: 300, // Ajusta según sea necesario
            width: double.infinity, // Ajusta según sea necesario
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        descripcion,
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        maxLines: 3, // Ajusta según sea necesario
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '$eventPrice €',
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookPage(
                              imageUrl: imageUrl,
                              date: date,
                              price: eventPrice,
                              eventName: eventName,
                              uuid: id,
                            )));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Cambia el color de fondo del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Book Now',
                style: GoogleFonts.manrope(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
