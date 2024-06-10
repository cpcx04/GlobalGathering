import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { CommentResponse } from '../../models/comments.interface';

@Injectable({
  providedIn: 'root'
})
export class CommentService{
 
    private apiUrl = 'http://localhost:8080/comments';
    private authTokenKey = 'authToken';
  
    constructor(private http: HttpClient) {}

  getAllComments() : Observable<CommentResponse[]> {
    return this.http.get<CommentResponse[]>(`${this.apiUrl}/singleComments`, {
      headers: new HttpHeaders({
        'Authorization': `Bearer ${localStorage.getItem(this.authTokenKey)}`
      })
    }).pipe(
      catchError(this.handleError)
    );
  }
  deleteComment(uuid: string): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/delete/${uuid}`, {
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