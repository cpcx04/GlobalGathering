part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class DoCommentEvent extends CommentEvent {
  final String comments;
  DoCommentEvent(this.comments);
}

class DoCreateCommentEvent extends CommentEvent {
  final String? username;
  final String content;
  final String? relatedPost;
  DoCreateCommentEvent(this.username, this.content, this.relatedPost);
}
