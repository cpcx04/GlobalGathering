import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateCommentWidget extends StatelessWidget {
  const CreateCommentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ClipOval(
                child: Image.network(
                  'https://static.vecteezy.com/system/resources/thumbnails/011/381/900/small/young-businessman-3d-cartoon-avatar-portrait-png.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: 'Write a comment...',
                ),
                style: GoogleFonts.inter(
                  fontSize: 14,
                ),
                maxLines: null, // Allow multiline input
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 20, 12, 71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Post',
                style: GoogleFonts.manrope(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
