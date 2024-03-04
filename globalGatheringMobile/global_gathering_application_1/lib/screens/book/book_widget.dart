import 'package:flutter/material.dart';
import 'package:global_gathering_application_1/repository/event/event_repository.dart';
import 'package:global_gathering_application_1/repository/event/event_repository_impl.dart';
import 'package:global_gathering_application_1/screens/book/book_page.dart';
import 'package:global_gathering_application_1/widgets/comments/comment_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class BookPage extends StatelessWidget {
  final String uuid;
  final String imageUrl;
  final String date;
  final String price;
  final String eventName;

  const BookPage({
    Key? key,
    required this.imageUrl,
    required this.date,
    required this.price,
    required this.eventName,
    required this.uuid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 8),
                          Text('Ubicación'),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.event),
                          const SizedBox(width: 8),
                          Text(date),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    eventName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Precio: $price €',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _showPaymentModal(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary:
                            Colors.blue, // Cambia el color de fondo del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Pay Now',
                        style: GoogleFonts.manrope(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  //Aqui van los comentarios sobre un evento relacionado
                  const CommentWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Pagar por el evento',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(labelText: 'Número de tarjeta'),
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(labelText: 'Fecha de caducidad'),
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(labelText: 'CVV'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookedTravels(
                              uuid: uuid,
                            )),
                  );
                },
                child: const Text('Pagar'),
              ),
            ],
          ),
        );
      },
    );
  }
}
