import { Component } from '@angular/core';
import { CommentService } from '../../services/comments/comment.service';
import { CommentResponse } from '../../models/comments.interface';

@Component({
  selector: 'app-table-comments-ui',
  templateUrl: './table-comments-ui.component.html',
  styleUrls: ['./table-comments-ui.component.css']
})
export class TableCommentsUiComponent {
  searchQuery: string = '';
  comments: CommentResponse[] = [];
  selectedComment: CommentResponse | null = null;
  isDeleteModalOpen: boolean = false;
  errorMessage: string = '';
  currentPage: number = 1;
  itemsPerPage: number = 10;

  constructor(private commentService: CommentService) { }

  ngOnInit(): void {
    this.commentService.getAllComments().subscribe(response => {
      this.comments = response;
      console.log(response)
    });
  }

  get totalPages(): number {
    let filtered = this.comments.filter(comment =>
      comment.username.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
      comment.content.toLowerCase().includes(this.searchQuery.toLowerCase())
    );

    return Math.ceil(filtered.length / this.itemsPerPage);
  }

  changePage(page: number): void {
    if (page >= 1 && page <= this.totalPages) {
      this.currentPage = page;
    }
  }

  get filteredComments(): CommentResponse[] {
    let filtered = this.comments.filter(comment =>
      comment.username.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
      comment.content.toLowerCase().includes(this.searchQuery.toLowerCase())
    );

    const startIndex = (this.currentPage - 1) * this.itemsPerPage;
    return filtered.slice(startIndex, startIndex + this.itemsPerPage);
  }

  deleteComment(comment: CommentResponse): void {
    this.selectedComment = comment;
    this.isDeleteModalOpen = true;
  }

  onConfirmDelete(): void {
    if (this.selectedComment) {
      console.log(this.selectedComment.uuid)
      this.commentService.deleteComment(this.selectedComment.uuid).subscribe(() => {
        // Eliminación exitosa, actualizar la lista de comentarios
        this.comments = this.comments.filter(comment => comment.uuid !== this.selectedComment!.uuid);
        this.isDeleteModalOpen = false;
      }, () => {
        // Si hay un error al eliminar, mostrar un mensaje de error
        this.errorMessage = 'Error borrando el comentario';
        this.isDeleteModalOpen = false;
      });
    }
  }

  onCloseModal(): void {
    this.selectedComment = null;
    this.isDeleteModalOpen = false;
  }

  clearError(): void {
    this.errorMessage = '';
  }
}
