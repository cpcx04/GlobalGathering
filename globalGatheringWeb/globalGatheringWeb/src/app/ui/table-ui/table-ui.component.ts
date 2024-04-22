import { Component, OnInit } from '@angular/core';
import { ClienteService } from '../../services/clientes/cliente.service';
import { ClienteResponse } from '../../models/clients.interface';


@Component({
  selector: 'app-table-ui',
  templateUrl: './table-ui.component.html',
  styleUrls: ['./table-ui.component.css']
})
export class TableUiComponent implements OnInit {
  
deleteUser(_t14: ClienteResponse) {
throw new Error('Method not implemented.');
}
editUser(_t14: ClienteResponse) {
throw new Error('Method not implemented.');
}
  clientes: ClienteResponse[] = [];

  constructor(private clienteService: ClienteService) { }

  ngOnInit(): void {
    this.clienteService.getAllClients().subscribe(response => {
      this.clientes = response;
    });
  }
}
