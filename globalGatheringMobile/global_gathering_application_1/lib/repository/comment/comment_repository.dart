import 'package:global_gathering_application_1/model/dto/comment_dto.dart';
import 'package:global_gathering_application_1/model/reponse/comment_response.dart';

abstract class CommentRepository {
  Future<List<CommentResponse>> getComments();
  Future<CommentResponse> createAcomment(CommentDto commentDto);
  Future<void> deleteComment(String commentId);
}
