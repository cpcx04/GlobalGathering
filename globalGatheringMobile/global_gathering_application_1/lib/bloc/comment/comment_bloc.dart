import 'package:bloc/bloc.dart';
import 'package:global_gathering_application_1/model/reponse/comment_response.dart';
import 'package:global_gathering_application_1/repository/comment/comment_repository.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository _commentRepository;
  CommentBloc(this._commentRepository) : super(CommentInitial()) {
    on<CommentEvent>(_onCommentFetchList);
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
}