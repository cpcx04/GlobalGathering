import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventWidget extends StatelessWidget {
  final String imagePath;
  final String eventName;
  final String location;

  const EventWidget({
    Key? key,
    required this.imagePath,
    required this.eventName,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
                height: 120,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8),
            child: Text(
              eventName,
              style: GoogleFonts.manrope(
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 12,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
