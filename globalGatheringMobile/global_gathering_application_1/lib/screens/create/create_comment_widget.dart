import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:global_gathering_application_1/bloc/comment/comment_bloc.dart';

class CreateCommentWidget extends StatefulWidget {
  const CreateCommentWidget({Key? key}) : super(key: key);

  @override
  State<CreateCommentWidget> createState() => _CreateCommentWidgetState();
}

class _CreateCommentWidgetState extends State<CreateCommentWidget> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CreateCommentSucess) {
          // Aquí puedes manejar la lógica después de crear el comentario
        }

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
                    controller: _commentController,
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
                  onPressed: () {
                    final comment = _commentController.text;
                    if (comment.isNotEmpty) {
                      // Supongamos que obtienes estos valores de alguna manera
                      final username = "Username";
                      final content = comment;
                      final relatedPost = "RelatedPostID";

                      context.read<CommentBloc>().add(
                            DoCreateCommentEvent(
                                username, content, relatedPost),
                          );
                    }
                  },
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
      },
    );
  }
}
