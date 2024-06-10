import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { ClienteResponse, ClienteDto } from '../../models/clients.interface';

@Injectable({
  providedIn: 'root'
})
export class ClienteService {

  private apiUrl = 'http://localhost:8080/';
  private authTokenKey = 'authToken';

  constructor(private http: HttpClient) { }

  getAllClients(): Observable<ClienteResponse[]> {
    const authToken = localStorage.getItem(this.authTokenKey);
    const headers = new HttpHeaders({
      'Authorization': 'Bearer ' + authToken
    });
    return this.http.get<ClienteResponse[]>(`${this.apiUrl}admin/clients`, { headers })
      .pipe(
        catchError((error: HttpErrorResponse) => {
          let errorMessage = 'An error occurred while fetching clients.';
          // Agregar aquí la lógica para manejar los diferentes tipos de errores si es necesario
          return throwError(errorMessage);
        })
      );
  }

  editClient(username: string, clientDto: ClienteDto): Observable<ClienteResponse> {
    const authToken = localStorage.getItem(this.authTokenKey);
    const headers = new HttpHeaders({
      'Authorization': 'Bearer ' + authToken,
      'Content-Type': 'application/json'
    });
    return this.http.put<ClienteResponse>(`${this.apiUrl}admin/clients/${username}`, clientDto, { headers })
      .pipe(
        catchError((error: HttpErrorResponse) => {
          let errorMessage = 'An error occurred while editing the client.';
          // Agregar aquí la lógica para manejar los diferentes tipos de errores si es necesario
          return throwError(errorMessage);
        })
      );
  }

  deleteClient(username: string): Observable<any> {
    const authToken = localStorage.getItem(this.authTokenKey);
    const headers = new HttpHeaders({
      'Authorization': 'Bearer ' + authToken
    });
    return this.http.delete(`${this.apiUrl}admin/clients/${username}`, { headers })
      .pipe(
        catchError((error: HttpErrorResponse) => {
          let errorMessage = 'An error occurred while deleting the client.';
          // Agregar aquí la lógica para manejar los diferentes tipos de errores si es necesario
          return throwError(errorMessage);
        })
      );
  }
  
}
