import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/repository/comment/comment_repository.dart';
import 'package:global_gathering_application_1/repository/comment/comment_repository_impl.dart';
import 'package:global_gathering_application_1/screens/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:global_gathering_application_1/bloc/comment/comment_bloc.dart';

class CreateCommentWidget extends StatefulWidget {
  const CreateCommentWidget({Key? key}) : super(key: key);

  @override
  State<CreateCommentWidget> createState() => _CreateCommentWidgetState();
}

class _CreateCommentWidgetState extends State<CreateCommentWidget> {
  final _formComment = GlobalKey<FormState>();
  final contentTextController = TextEditingController();

  late CommentRepository commentRepository;
  late CommentBloc _commentBloc;

  @override
  void initState() {
    commentRepository = CommentRepositoryImpl();
    _commentBloc = CommentBloc(commentRepository);
    super.initState();
  }

  @override
  void dispose() {
    contentTextController.dispose();
    _commentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      BlocProvider.value(
        value: _commentBloc,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<CommentBloc, CommentState>(
              buildWhen: (context, state) {
                return state is CommentInitial ||
                    state is CreateCommentSucess ||
                    state is CommentError ||
                    state is CommentFetchLoading;
              },
              builder: (context, state) {
                if (state is CreateCommentSucess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  });
                } else if (state is CommentError) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('The comment cant be created'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else if (state is CommentFetchLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Center(child: _buildCommentForm());
              },
              listener: (BuildContext context, CommentState state) {}),
        ),
      )
    ]);
  }

  _buildCommentForm() {
    return Form(
      key: _formComment,
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
              child: TextFormField(
                controller: contentTextController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: 'Write a comment...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You cant post an empty comment';
                  }
                  return null;
                },
                style: GoogleFonts.inter(
                  fontSize: 14,
                ),
                maxLines: null, // Allow multiline input
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formComment.currentState!.validate()) {
                  _commentBloc.add(DoCreateCommentEvent.withoutRelatedPost(
                      contentTextController.text));
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
  }
}
