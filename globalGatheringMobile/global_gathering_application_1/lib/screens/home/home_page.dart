import 'package:flutter/material.dart';
import 'package:global_gathering_application_1/widgets/events/event_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final String name;
  const HomePage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What do',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "you want to do?",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.manrope(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 12, bottom: 12),
                  child: Text(
                    "Explore Cities",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      EventWidget(
                        imagePath:
                            'https://upload.wikimedia.org/wikipedia/commons/b/b6/Plaza_de_España_%28Sevilla%29_-_01.jpg',
                        location: 'Plaza de España',
                        eventName: 'Excursion a la Plaza de España',
                      ),
                      EventWidget(
                        imagePath:
                            'https://offloadmedia.feverup.com/sevillasecreta.co/wp-content/uploads/2020/06/24070607/shutterstock_1324665797-1-1024x651.jpg',
                        location: 'Parque de Maria Luisa',
                        eventName: 'Paseo Parque Maria Luisa',
                      ),
                      EventWidget(
                        imagePath:
                            'https://visitasevilla.es/wp-content/uploads/2022/11/setas.jpg',
                        location: 'Setas de Sevilla',
                        eventName: 'Visita a Setas de Sevilla',
                      ),
                      EventWidget(
                        imagePath:
                            'https://upload.wikimedia.org/wikipedia/commons/b/b6/Plaza_de_España_%28Sevilla%29_-_01.jpg',
                        location: 'Plaza de España',
                        eventName: 'Excursion a la Plaza de España',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 0.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                30.0), // Ajusta el radio según tus preferencias
            color: const Color.fromARGB(255, 20, 12,
                71), // Puedes ajustar el color de fondo según tus preferencias
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.home),
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.travel_explore),
                  color: Colors.white,
                ),
              ),
              const SizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.video_collection_rounded),
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 20, 12, 71),
        onPressed: () {
          // Add your functionality for the FloatingActionButton
        },
        child: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );
  }
}
