import 'package:flutter/material.dart';
import 'package:global_gathering_application_1/screens/travel/travel_screen.dart';

class MyEventCard extends StatelessWidget {
  final String imagePath;
  final String eventName;
  final String location;
  final double latitud;
  final double longitud;

  const MyEventCard({
    Key? key,
    required this.imagePath,
    required this.eventName,
    required this.location,
    required this.latitud,
    required this.longitud,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TravelPage(
              latitud: latitud,
              longitud: longitud,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Imagen a la izquierda
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      imagePath), // Puedes cambiar a AssetImage si es una imagen local
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Texto a la derecha
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(location),
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
