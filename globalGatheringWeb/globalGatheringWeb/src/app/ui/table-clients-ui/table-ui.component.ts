import { Component, OnInit } from '@angular/core';
import { ClienteService } from '../../services/clientes/cliente.service';
import { ClienteResponse, ClienteDto } from '../../models/clients.interface';

@Component({
  selector: 'app-table-ui',
  templateUrl: './table-ui.component.html',
  styleUrls: ['./table-ui.component.css']
})
export class TableUiComponent implements OnInit {
  searchQuery: string = '';
  clientes: ClienteResponse[] = [];
  selectedCliente: ClienteResponse | null = null;
  isDeleteModalOpen: boolean = false;
  isEditModalOpen: boolean = false;
  errorMessage: string = '';
  currentPage: number = 1;
  itemsPerPage: number = 10;

  constructor(private clienteService: ClienteService) { }

  ngOnInit(): void {
    this.clienteService.getAllClients().subscribe(response => {
      this.clientes = response;
    });
  }



  get totalPages(): number {
    let filtered = this.clientes.filter(cliente =>
      cliente.username.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
      cliente.email.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
      cliente.nombre.toLowerCase().includes(this.searchQuery.toLowerCase())
    );

    return Math.ceil(filtered.length / this.itemsPerPage);
  }

  changePage(page: number): void {
    if (page >= 1 && page <= this.totalPages) {
      this.currentPage = page;
    }
  }
  deleteUserConfirmation(cliente: ClienteResponse) {
    this.selectedCliente = cliente;
    this.isDeleteModalOpen = true;
  }

  cancelEditUser(){
    this.isEditModalOpen = false;
    this.selectedCliente = null;
  }

  cancelDeleteUser() {
    this.isDeleteModalOpen = false;
    this.selectedCliente = null;
  }

  editUser(cliente: ClienteResponse) {
    this.selectedCliente = cliente;
    this.isEditModalOpen = true;
  }

  confirmDeleteUser() {
    if (this.selectedCliente) {
      this.clienteService.deleteClient(this.selectedCliente.username).subscribe(
        () => {
          console.log('Cliente eliminado exitosamente');
          const index = this.clientes.indexOf(this.selectedCliente!);
          if (index !== -1) {
            this.clientes.splice(index, 1);
          }
          this.isDeleteModalOpen = false;
          this.selectedCliente = null;
        },
        error => {
          console.error('Error al eliminar el cliente:', error);
          this.errorMessage = 'Error occurred: ' + error.message; // Assuming error has a 'message' property
        }
      );
    }
  }
  

  saveEditedUser() {
    if (this.selectedCliente) {
      const clienteDto: ClienteDto = {
        username: this.selectedCliente.username,
        email: this.selectedCliente.email,
        fullName: this.selectedCliente.nombre,
        role: this.selectedCliente.role
      };

      this.clienteService.editClient(this.selectedCliente.username, clienteDto).subscribe(
        updatedCliente => {
          console.log('Usuario editado:', updatedCliente);
          const index = this.clientes.findIndex(c => c.username === updatedCliente.username);
          if (index !== -1) {
            this.clientes[index] = updatedCliente;
          }
          this.isEditModalOpen = false;
          this.selectedCliente = null;
        },
        error => {
          console.error('Error al eliminar el cliente:', error);
          this.errorMessage = 'Error occurred: ' + error.message; // Assuming error has a 'message' property
        }
      );
    }
  }

  get filteredClientes(): ClienteResponse[] {
    let filtered = this.clientes.filter(cliente =>
      cliente.username.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
      cliente.email.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
      cliente.nombre.toLowerCase().includes(this.searchQuery.toLowerCase())
    );

    const startIndex = (this.currentPage - 1) * this.itemsPerPage;
    return filtered.slice(startIndex, startIndex + this.itemsPerPage);
  }
  clearError() {
    this.errorMessage = '';
  }
  
}
