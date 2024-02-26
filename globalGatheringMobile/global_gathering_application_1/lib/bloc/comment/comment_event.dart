part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class DoCommentEvent extends CommentEvent {
  final String comments;
  DoCommentEvent(this.comments);
}
