import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ImageService {
    private authTokenKey = 'authToken';
  constructor(private http: HttpClient) {}

  getImage(uri: string): Observable<Blob> {
    const authToken = localStorage.getItem(this.authTokenKey);
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${authToken}`
    });
    return this.http.get(uri, { headers, responseType: 'blob' });
  }
}
