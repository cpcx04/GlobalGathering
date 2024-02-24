part of 'comment_bloc.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class CommentDetail extends CommentState {}

final class CommentFetchLoading extends CommentState {}

final class CommentFetchSucess extends CommentState {
  final List<CommentResponse> comment;

  CommentFetchSucess(this.comment);
}

final class CommentError extends CommentState {
  final String message;
  CommentError(this.message);
}
