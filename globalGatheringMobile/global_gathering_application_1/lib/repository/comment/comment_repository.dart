import 'package:global_gathering_application_1/model/reponse/comment_response.dart';

abstract class CommentRepository {
  Future<List<CommentResponse>> getComments();
}
