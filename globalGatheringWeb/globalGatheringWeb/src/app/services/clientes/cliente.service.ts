import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
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
    return this.http.get<ClienteResponse[]>(`${this.apiUrl}admin/clients`, { headers });
  }

  editClient(username: string, clientDto: ClienteDto): Observable<ClienteResponse> {
    const authToken = localStorage.getItem(this.authTokenKey);
    const headers = new HttpHeaders({
      'Authorization': 'Bearer ' + authToken,
      'Content-Type': 'application/json'
    });
    return this.http.put<ClienteResponse>(`${this.apiUrl}admin/clients/${username}`, clientDto, { headers });
  }
}
