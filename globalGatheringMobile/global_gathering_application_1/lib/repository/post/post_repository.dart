import 'package:global_gathering_application_1/model/dto/post_dto.dart';
import 'package:global_gathering_application_1/model/reponse/post_response.dart';
import 'dart:io';

abstract class PostRepository {
  Future<PostResponse> newPost(PostDto postDto, File file);
  Future<List<PostResponse>> getMyPosts();
}
