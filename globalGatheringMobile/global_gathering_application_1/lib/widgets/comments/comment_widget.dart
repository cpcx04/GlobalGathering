import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_gathering_application_1/bloc/comment/comment_bloc.dart';
import 'package:global_gathering_application_1/repository/comment/comment_repository.dart';
import 'package:global_gathering_application_1/repository/comment/comment_repository_impl.dart';
import 'package:global_gathering_application_1/widgets/comments/comment_card.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({super.key});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late CommentRepository commentRepository;

  @override
  void initState() {
    super.initState();
    commentRepository = CommentRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CommentBloc(commentRepository)..add(DoCommentEvent('comment')),
      child: _commentList(),
    );
  }
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
            return CommentCard(
              userProfileImage: comment.avatar!,
              username: comment.username!,
              commentContent: comment.content!,
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
