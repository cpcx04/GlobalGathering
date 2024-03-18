import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { enviroment } from '../enviroments/enviroment';
import { LoginResponse } from '../models/login-response.interface';

@Injectable({
    providedIn:'root'
})
export class AuthService{
    constructor(private http: HttpClient){}
    
    login(username: string,password:string): Observable<LoginResponse>{
        return this.http.post<LoginResponse>(`${enviroment.apiBaseUrl}/auth/login`,{
            username: username,
            password: password,
        },{
            headers: {
            'Content-Type': 'application/json',
            }
        })
    }
}