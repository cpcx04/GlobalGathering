import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Events } from '../../models/events-response.interface';
import { AddEventDto } from '../../models/events-response.interface';

@Injectable({
  providedIn: 'root'
})
export class EventService {
 
  
  private apiUrl = 'http://localhost:8080/event';
  private authTokenKey = 'authToken';

  constructor(private http: HttpClient) {}

  getEvents(): Observable<Events[]> {
    return this.http.get<Events[]>(`${this.apiUrl}/allEvents`, {
      headers: new HttpHeaders({
        'Authorization': `Bearer ${localStorage.getItem(this.authTokenKey)}`
      })
    }).pipe(
      catchError(this.handleError)
    );
  }
  deleteEvent(uuid: string): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${uuid}`, {
      headers: new HttpHeaders({
        'Authorization': `Bearer ${localStorage.getItem(this.authTokenKey)}`
      })
    }).pipe(
      catchError(this.handleError)
    );
  }
  updateEvent(uuid: string, event: AddEventDto): Observable<Events> {
    return this.http.put<Events>(`${this.apiUrl}/${uuid}`, event, {
      headers: new HttpHeaders({
        'Authorization': `Bearer ${localStorage.getItem(this.authTokenKey)}`
      })
    }).pipe(
      catchError(this.handleError)
    );
  }

  private handleError(error: HttpErrorResponse) {
    if (error.error instanceof ErrorEvent) {
      console.error('An error occurred:', error.error.message);
    } else {
      console.error(
        `Backend returned code ${error.status}, ` +
        `body was: ${error.error}`);
    }
    return throwError('Something bad happened; please try again later.');
  }
}
