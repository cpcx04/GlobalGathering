import 'package:flutter/material.dart';
import 'package:global_gathering_application_1/screens/book/booked_page.dart';
import 'package:global_gathering_application_1/screens/create/create_screen.dart';
import 'package:global_gathering_application_1/screens/home/home_page.dart';
import 'package:global_gathering_application_1/screens/travel/travel_screen.dart';

import 'package:google_fonts/google_fonts.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
                  'We are working on this page...',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  icon: const Icon(Icons.home),
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TravelPage(
                                latitud: 37.39216297919158,
                                longitud: -6.002893650469156,
                              )),
                    );
                  },
                  icon: const Icon(Icons.travel_explore),
                  color: Colors.white,
                ),
              ),
              const SizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mode_of_travel_sharp),
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookedPage()),
                    );
                  },
                  icon: const Icon(Icons.person),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );
  }
}
