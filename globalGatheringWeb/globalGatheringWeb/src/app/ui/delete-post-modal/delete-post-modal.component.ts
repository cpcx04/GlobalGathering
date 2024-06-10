import { Component, EventEmitter, Output } from '@angular/core';

@Component({
  selector: 'app-delete-post-modal',
  templateUrl: './delete-post-modal.component.html',
  styleUrls: ['./delete-post-modal.component.css']
})
export class DeletePostModalComponent {
  @Output() closeModal = new EventEmitter<void>();
  @Output() confirmDelete = new EventEmitter<void>();

  onCloseModal() {
    this.closeModal.emit();
  }

  onConfirmDelete() {
    this.confirmDelete.emit();
  }
}
