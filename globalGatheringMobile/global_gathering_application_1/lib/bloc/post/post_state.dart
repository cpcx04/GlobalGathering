part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

final class GetPostDetail extends PostState {}

final class GetPostFetchLoading extends PostState {}

final class PostErrorState extends PostState {
  final String message;
  PostErrorState(this.message);
}

final class GetAllMyPostFetchSuccess extends PostState {
  final List<PostResponse> posts;
  GetAllMyPostFetchSuccess(this.posts);
}

final class GetPostFetchSuccess extends PostState {
  final PostResponse post;
  final XFile file;
  GetPostFetchSuccess(this.post, this.file);
}
