import 'package:bloc/bloc.dart';
import 'package:global_gathering_application_1/model/dto/comment_dto.dart';
import 'package:global_gathering_application_1/model/reponse/comment_response.dart';
import 'package:global_gathering_application_1/repository/comment/comment_repository.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository _commentRepository;
  CommentBloc(this._commentRepository) : super(CommentInitial()) {
    on<DoCommentEvent>(_onCommentFetchList);
    on<DoCreateCommentEvent>(_onCreateComment);
    on<DoDeleteCommentEvent>(_onDeleteComment);
  }

  void _onCommentFetchList(
      CommentEvent comment, Emitter<CommentState> emit) async {
    try {
      final commentList = await _commentRepository.getComments();
      emit(CommentFetchSucess(commentList));
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }

  void _onCreateComment(
      DoCreateCommentEvent comment, Emitter<CommentState> emit) async {
    emit(CommentFetchLoading());
    try {
      final CommentDto commentDto = CommentDto(
          content: comment.content, relatedPost: comment.relatedPost);
      final CommentResponse commentResponse =
          await _commentRepository.createAcomment(commentDto);
      emit(CreateCommentSucess(commentResponse));
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }

  void _onDeleteComment(
      DoDeleteCommentEvent deleteEvent, Emitter<CommentState> emit) async {
    try {
      await _commentRepository.deleteComment(deleteEvent.commentId);

      final commentList = await _commentRepository.getComments();
      emit(CommentFetchSucess(commentList));

      emit(CommentDeleteSuccess());
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }
}
