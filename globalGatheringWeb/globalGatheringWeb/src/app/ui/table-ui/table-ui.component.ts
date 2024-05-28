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

  constructor(private clienteService: ClienteService) { }

  ngOnInit(): void {
    this.clienteService.getAllClients().subscribe(response => {
      this.clientes = response;
    });
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
        console.log('Usuario eliminado:', this.selectedCliente);
        const index = this.clientes.indexOf(this.selectedCliente);
        if (index !== -1) {
            this.clientes.splice(index, 1);
        }
    }
    this.isDeleteModalOpen = false;
    this.selectedCliente = null;
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
          console.error('Error al editar el usuario:', error);
          // Manejo de errores según sea necesario
        }
      );
    }
  }

  get filteredClientes(): ClienteResponse[] {
    return this.clientes.filter(cliente =>
      cliente.username.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
      cliente.email.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
      cliente.nombre.toLowerCase().includes(this.searchQuery.toLowerCase())
    );
  }
}
