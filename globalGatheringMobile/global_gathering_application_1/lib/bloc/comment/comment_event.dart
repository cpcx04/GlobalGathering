part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class DoCommentEvent extends CommentEvent {
  final String comments;
  DoCommentEvent(this.comments);
}

class DoCreateCommentEvent extends CommentEvent {
  final String content;
  final String? relatedPost;

  DoCreateCommentEvent.withRelatedPost(this.content, this.relatedPost);

  DoCreateCommentEvent.withoutRelatedPost(this.content) : relatedPost = null;
}

class DoDeleteCommentEvent extends CommentEvent {
  final String commentId;

  DoDeleteCommentEvent(this.commentId);
}
