import 'package:flutter/material.dart';
import 'package:global_gathering_application_1/screens/home/home_page.dart';

class TravelPage extends StatelessWidget {
  const TravelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(),
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
                      MaterialPageRoute(builder: (context) => TravelPage()),
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
