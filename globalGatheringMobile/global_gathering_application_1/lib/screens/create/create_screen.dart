import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            "Create",
            style: GoogleFonts.manrope(color: Colors.black),
          ),
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(25.0), // Altura de la barra de color
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: TabBar(
                labelStyle: GoogleFonts.manrope(),
                labelColor: const Color.fromARGB(255, 20, 12, 71),
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(
                    text: 'Comment',
                  ),
                  Tab(
                    text: 'Post',
                  ),
                  Tab(
                    text: 'Event',
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text(
                "Comment",
                style: GoogleFonts.manrope(),
              ),
            ),
            Center(
              child: Text(
                "Post",
                style: GoogleFonts.manrope(),
              ),
            ),
            Center(
              child: Text(
                "Event",
                style: GoogleFonts.manrope(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
