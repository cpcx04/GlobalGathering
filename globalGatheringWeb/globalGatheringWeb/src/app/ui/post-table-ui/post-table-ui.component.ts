import { Component, OnInit } from '@angular/core';
import { PostService } from '../../services/post/post.service';
import { NewPost, Post } from '../../models/post.interface';
import { HttpClient } from '@angular/common/http';
import { Events } from '../../models/events-response.interface';
import { EventService } from '../../services/events/events.service';
import { ImageService } from '../../services/image/image.service';

@Component({
  selector: 'app-post-table-ui',
  templateUrl: './post-table-ui.component.html',
  styleUrls: ['./post-table-ui.component.css']
})
export class PostTableUiComponent implements OnInit {

  posts: Post[] = [];
  filteredPosts: Post[] = [];
  searchQuery: string = '';
  newPost: NewPost = { relatedEvent: '', comment: '' }; 
  currentPage: number = 1;
  totalPages: number = 1;
  showDeleteModal: boolean = false;
  postToDelete: Post | null = null;
  authTokenKey = 'authToken';
  authToken: string | null = null;
  modalOpen: boolean = false;
  modalImageUrl: string = '';
  modalPostOpen: boolean = false;
  itemsPerPage: number = 4;
  selectedImage: File | null = null;
  events: Events[] = [];
  relatedEvents : string = '';
  previewImageUrl: string | ArrayBuffer | null = null;
  constructor(
    private postService: PostService,
    private imageService: ImageService,
    private http : HttpClient,
    private eventService: EventService,
  ) {}

  ngOnInit() {
    this.postService.getPosts().subscribe((data: Post[]) => {
      this.posts = data;
      this.filteredPosts = data;
      this.totalPages = Math.ceil(this.posts.length / this.itemsPerPage);
      this.applyPagination();
      this.loadImagesForPosts();
    });
     this.eventService.getEvents().subscribe((data: Events[]) => {
    this.events = data;
    console.log('Events fetched:', this.events); // Debugging log
  }, error => {
    console.error('Error fetching events:', error);
  });
}


  applyFilter() {

    this.filteredPosts = this.posts.filter(post =>
        post.comment.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
        post.createdBy.toLowerCase().includes(this.searchQuery.toLowerCase())
    );
}



  applyPagination() {
    const startIndex = (this.currentPage - 1) * this.itemsPerPage;
    const endIndex = startIndex + this.itemsPerPage;
    this.filteredPosts = this.posts.slice(startIndex, endIndex);
  }

  changePage(page: number) {
    if (page > 0 && page <= this.totalPages) {
      this.currentPage = page;
      this.applyPagination();
    }
  }
  get filteredPost(): Post[] {
    let filtered = this.posts.filter(post =>
      post.comment.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
      post.createdBy.toLowerCase().includes(this.searchQuery.toLowerCase())
    );

    const startIndex = (this.currentPage - 1) * this.itemsPerPage;
    return filtered.slice(startIndex, startIndex + this.itemsPerPage);
  }
  createNewPost() {
    if (this.newPost.relatedEvent && this.newPost.comment && this.selectedImage) {
      const formData = new FormData();
      formData.append('post', JSON.stringify(this.newPost));
      formData.append('file', this.selectedImage);
  
      this.postService.createNewPost(formData).subscribe((response: any) => {
        console.log('Post created successfully:', response);
        // Después de crear el post, actualiza la lista de posts
        this.postService.getPosts().subscribe((data: Post[]) => {
          this.posts = data;
          // Recalcula las páginas y muestra los resultados actualizados
          this.totalPages = Math.ceil(this.posts.length / this.itemsPerPage);
          this.applyPagination();
          this.loadImagesForPosts();
        });
        
        this.newPost = {
          relatedEvent: '',
          comment: ''
        };
        this.selectedImage = null;
        this.modalPostOpen = false; 
      });
    }
  }
  

  handleImageUpload(event: any) {
    const file = event.target.files[0];
    this.selectedImage = file;
  
    if (file) {
      const reader = new FileReader();
      reader.onload = (e: any) => {
        this.previewImageUrl = e.target.result;
      };
      reader.readAsDataURL(file);
    }
  }
  
  editPost(post: Post) {
    // Implement edit functionality
  }

  deletePostConfirmation(post: Post) {
    this.postToDelete = post;
    this.showDeleteModal = true;
  }

  handleModalClose(event: any) {
    this.showDeleteModal = false;
  }

  handleDeleteConfirmed(event: any) {
    if (this.postToDelete) {
      this.postService.deletePost(this.postToDelete.uuid).subscribe(() => {
        this.posts = this.posts.filter(post => post.uuid !== this.postToDelete!.uuid);
        this.applyFilter();
        this.showDeleteModal = false;
        this.postToDelete = null;
      });
    }
  }
  downloadImage(event: Event, imageUrl: string) {
    event.stopPropagation();
    this.http.get(imageUrl, { responseType: 'blob' }).subscribe(blob => {
        const parts = imageUrl.split('/');
        const filename = parts[parts.length - 1];
        // Create a link element
        const link = document.createElement('a');
        link.href = URL.createObjectURL(blob);
        link.download = filename+'.jpg'; // Set the download filename

        // Append link to the body, click it, and then remove it
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }, error => {
        console.error('Error downloading the image: ', error);
    });
  }
  // Función para cargar las imágenes de los posts
  loadImagesForPosts() {
    this.posts.forEach(post => {
      this.imageService.getImage(post.uri).subscribe((blob: Blob) => {
        const reader = new FileReader();
        reader.onloadend = () => {
          post.uri = reader.result as string;
        };
        reader.readAsDataURL(blob);
      });
    });
  }
  openModal(imageUrl: string) {
    this.modalImageUrl = imageUrl;
    this.modalOpen = true;
  }
  openPostModal() {
    this.modalPostOpen = true;
  }
  
  closePostModal() {
    this.modalPostOpen = false;
    }
  closeModal() {
    this.modalOpen = false;
    this.modalImageUrl = '';
  }
}
