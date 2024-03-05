// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/bloc/comment/comment_bloc.dart';
import 'package:global_gathering_application_1/repository/comment/comment_repository.dart';
import 'package:global_gathering_application_1/repository/comment/comment_repository_impl.dart';
import 'package:global_gathering_application_1/widgets/comments/comment_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({Key? key}) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late CommentRepository commentRepository;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    commentRepository = CommentRepositoryImpl();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
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
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.comment.length,
            itemBuilder: (context, index) {
              final comment = state.comment[index];
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
                  final SharedPreferences prefs = await _prefs;
                  final String? currentUsername = prefs.getString("username");

                  final bool isCurrentUserComment =
                      comment.username == currentUsername;

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
                    // Update the underlying data by removing the deleted comment
                    BlocProvider.of<CommentBloc>(context)
                        .add(DoDeleteCommentEvent(comment.uuid!));

                    // Trigger a rebuild after updating the data
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
