import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';
import { enviroment } from '../../enviroments/enviroment';
import { LoginResponse } from '../../models/login-response.interface';

@Injectable({
    providedIn: 'root'
})
export class AuthService {
    private apiUrl = `${enviroment.apiBaseUrl}/auth`;
    private authTokenKey = 'authToken';
    private nombre = 'nombre';
    private role = 'role';

    constructor(private http: HttpClient, private router: Router) { }

    login(username: string, password: string): Observable<LoginResponse> {
        return this.http.post<LoginResponse>(`${this.apiUrl}/login`, {
            username: username,
            password: password,
        }, {
            headers: {
                'Content-Type': 'application/json',
            },
        }).pipe(
            tap(response => {
                localStorage.setItem(this.authTokenKey, response.token);
                localStorage.setItem(this.nombre, response.nombre);
                localStorage.setItem(this.role, response.role);
                this.router.navigate(['/home']); 
            }),
            catchError(error => {
                throw error;
            })
        );
    }

    logout(): void {
        localStorage.removeItem(this.authTokenKey);
        this.router.navigate(['/login']);
    }

    isLoggedIn() {
        return !!localStorage.getItem(this.authTokenKey);
    }
}
