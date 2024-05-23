import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:global_gathering_application_1/model/dto/post_dto.dart';
import 'package:global_gathering_application_1/model/reponse/post_response.dart';
import 'package:global_gathering_application_1/repository/post/post_repository.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;
  PostBloc(this._postRepository) : super(PostInitial()) {
    on<DoCreatePostEvent>(_onCreateEvent);
    on<GetAllMyPostEvent>(_onAllMyPosts);
  }

  void _onAllMyPosts(
      GetAllMyPostEvent postEvent, Emitter<PostState> emit) async {
    try {
      final List<PostResponse> list = await _postRepository.getMyPosts();
      emit(GetAllMyPostFetchSuccess(list));
    } catch (e) {
      emit(PostErrorState("Error getting posts: $e"));
    }
  }

  void _onCreateEvent(
      DoCreatePostEvent postEvent, Emitter<PostState> emit) async {
    try {
      final PostDto postDto = PostDto(
          relatedEvent: postEvent.relatedEvent, comment: postEvent.comment);
      final XFile file = postEvent.file;
      final post = await _postRepository.newPost(postDto, file);
      emit(GetPostFetchSuccess(post, file));
    } catch (e) {
      emit(PostErrorState("Error creating post: $e"));
    }
  }
}
