import { Component, OnInit } from '@angular/core';
import { Events, AddEventDto } from '../../models/events-response.interface';
import { EventService } from '../../services/events/events.service';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-table-events-ui',
  templateUrl: './table-events-ui.component.html',
  styleUrls: ['./table-events-ui.component.css']
})
export class TableEventsUiComponent implements OnInit {

  events: Events[] = [];
  filteredEvents: Events[] = [];
  searchQuery: string = '';
  editingEvent: Events | null = null;
  showModal: boolean = false;
  modalImageOpen: boolean = false;
  modalImageUrl: string = '';
  currentPage: number = 1;
  itemsPerPage: number = 5;
  showDeleteConfirmation: boolean = false;
  eventToDelete: Events | null = null;
  errorMessage: string = '';
  showRelatedPostErrorModal: boolean = false;

  constructor(private eventService: EventService,private http : HttpClient) {}

  ngOnInit(): void {
    this.eventService.getEvents().subscribe(
      data => {
        this.events = data;
        this.applyFilter();
      },
      error => {
        console.error('There was an error!', error);
      }
    );
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
  get totalPages(): number {
    return Math.ceil(this.getFilteredEvents().length / this.itemsPerPage);
  }

  changePage(page: number): void {
    if (page >= 1 && page <= this.totalPages) {
      this.currentPage = page;
      this.applyFilter();
    }
  }

  getFilteredEvents(): Events[] {
    return this.events.filter(event =>
      event.name.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
      event.descripcion.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
      event.createdBy.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
      event.ciudad.toLowerCase().includes(this.searchQuery.toLowerCase())
    );
  }

  applyFilter(): void {
    const filtered = this.getFilteredEvents();
    const startIndex = (this.currentPage - 1) * this.itemsPerPage;
    this.filteredEvents = filtered.slice(startIndex, startIndex + this.itemsPerPage);
  }


  
  getEventStatusColor(eventDate: string): string {
    const today = new Date().setHours(0, 0, 0, 0);
    const eventDateObj = new Date(eventDate).setHours(0, 0, 0, 0);

    if (eventDateObj < today) {
      return 'bg-red-500';
    } else if (eventDateObj === today) {
      return 'bg-yellow-500';
    } else {
      return 'bg-green-500';
    }
  }

  editEvent(event: Events): void {
    this.editingEvent = { ...event }; // Clone the event object
    this.showModal = true;
  }

  closeModal(): void {
    this.showModal = false;
    this.editingEvent = null;
  }
  openImageModal(imageUrl: string) {
    this.modalImageUrl = imageUrl;
    this.modalImageOpen = true;
  }

  closeImageModal() {
    this.modalImageOpen = false;
    this.modalImageUrl = '';
  }
  saveEvent(): void {
    if (this.editingEvent) {
      const updateEventDto: AddEventDto = {
        name: this.editingEvent.name,
        descripcion: this.editingEvent.descripcion,
        date: this.editingEvent.date,
        latitude: this.editingEvent.latitud,
        longitude: this.editingEvent.longitud,
        url: this.editingEvent.url,
        price: this.editingEvent.price,
        ciudad: this.editingEvent.ciudad
      };

      this.eventService.updateEvent(this.editingEvent.id, updateEventDto).subscribe(
        updatedEvent => {
          const index = this.events.findIndex(e => e.id === updatedEvent.id);
          if (index !== -1) {
            this.events[index] = updatedEvent;
            this.applyFilter();
          }
          this.closeModal();
        },
        error => {
          console.error('There was an error!', error);
        }
      );
    }
  }

  deleteEvent(event: Events): void {
    this.eventToDelete = event;
    this.showDeleteConfirmation = true;
  }
  
  confirmDelete(): void {
    if (this.eventToDelete) {
      this.eventService.deleteEvent(this.eventToDelete.id).subscribe(
        () => {
          this.events = this.events.filter(e => e.id !== this.eventToDelete!.id);
          this.applyFilter();
          this.showDeleteConfirmation = false;
          // Aquí podrías mostrar algún mensaje de éxito si lo deseas
        },
        error => {
          this.errorMessage = 'Este evento tienes posts relacionados,por favor elimine primero los post relacionados con el evento';
          this.showRelatedPostErrorModal = true;
          this.showDeleteConfirmation = false; // Cierra el modal de confirmación
        }
      );
    }
  }
  
  clearDeleteError(): void {
    this.errorMessage = ''; // Limpia el mensaje de error
    this.showRelatedPostErrorModal = false;
  }
  
  cancelDelete(): void {
    this.showDeleteConfirmation = false; // Cierra el modal de confirmación sin eliminar el evento
  }
  
  clearError(): void {
    this.errorMessage = ''; // Limpia el mensaje de error
  }
}
