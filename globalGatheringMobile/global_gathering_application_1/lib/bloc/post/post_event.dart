part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

class DoGetPostEvent extends PostEvent {
  final PostResponse post;
  DoGetPostEvent(this.post);
}

class GetMyPostEvent extends PostEvent {
  final List<PostResponse> posts;
  GetMyPostEvent(this.posts);
}

class GetAllMyPostEvent extends PostEvent {
  final String posts;
  GetAllMyPostEvent(this.posts);
}

class DoCreatePostEvent extends PostEvent {
  final String relatedEvent;
  final String comment;
  final File file;
  DoCreatePostEvent(
      {required this.relatedEvent, required this.comment, required this.file});
}
