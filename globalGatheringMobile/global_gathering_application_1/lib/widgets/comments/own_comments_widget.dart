// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/bloc/comment/comment_bloc.dart';
import 'package:global_gathering_application_1/repository/comment/comment_repository.dart';
import 'package:global_gathering_application_1/repository/comment/comment_repository_impl.dart';
import 'package:global_gathering_application_1/widgets/comments/comment_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCommentWidget extends StatefulWidget {
  const MyCommentWidget({Key? key}) : super(key: key);

  @override
  State<MyCommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<MyCommentWidget> {
  late CommentRepository commentRepository;
  late SharedPreferences _prefs;
  late String? _currentUsername;

  @override
  void initState() {
    super.initState();
    commentRepository = CommentRepositoryImpl();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _currentUsername = _prefs.getString("username");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CommentBloc(commentRepository)..add(DoCommentEvent('comment')),
      child: _commentList(),
    );
  }

  Widget _commentList() {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentFetchSucess) {
          // Filtrar comentarios por nombre de usuario
          final filteredComments = state.comment
              .where((comment) => comment.username == _currentUsername)
              .toList();

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredComments.length,
            itemBuilder: (context, index) {
              final comment = filteredComments[index];
              return Dismissible(
                key: Key(comment.uuid.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16.0),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                confirmDismiss: (DismissDirection direction) async {
                  final bool isCurrentUserComment =
                      comment.username == _currentUsername;

                  if (!isCurrentUserComment) {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: const Text(
                              "You can only delete your own comments."),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                    return false;
                  }

                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm"),
                        content: const Text(
                            "Are you sure you want to delete this comment?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (DismissDirection direction) {
                  if (direction == DismissDirection.endToStart) {
                    BlocProvider.of<CommentBloc>(context)
                        .add(DoDeleteCommentEvent(comment.uuid!));

                    setState(() {});
                  }
                },
                child: CommentCard(
                  userProfileImage: comment.avatar!,
                  username: comment.username!,
                  commentContent: comment.content!,
                ),
              );
            },
          );
        } else if (state is CommentError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
