import { Component, OnInit } from '@angular/core';
import { Event, AddEventDto } from '../../models/events-response.interface';
import { EventService } from '../../services/events/events.service';

@Component({
  selector: 'app-table-events-ui',
  templateUrl: './table-events-ui.component.html',
  styleUrls: ['./table-events-ui.component.css']
})
export class TableEventsUiComponent implements OnInit {
  events: Event[] = [];
  filteredEvents: Event[] = [];
  searchQuery: string = '';
  editingEvent: Event | null = null;
  showModal: boolean = false;
  currentPage: number = 1;
  itemsPerPage: number = 5;

  constructor(private eventService: EventService) {}

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

  get totalPages(): number {
    return Math.ceil(this.getFilteredEvents().length / this.itemsPerPage);
  }

  changePage(page: number): void {
    if (page >= 1 && page <= this.totalPages) {
      this.currentPage = page;
      this.applyFilter();
    }
  }

  getFilteredEvents(): Event[] {
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

  editEvent(event: Event): void {
    this.editingEvent = { ...event }; // Clone the event object
    this.showModal = true;
  }

  closeModal(): void {
    this.showModal = false;
    this.editingEvent = null;
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

  deleteUserConfirmation(event: Event): void {
    // Implement delete logic here
  }
}
