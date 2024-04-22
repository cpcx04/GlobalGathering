import { Injectable } from '@angular/core';

import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router } from '@angular/router';

import { Observable } from 'rxjs';
import { AuthService } from './auth.service';


 

@Injectable({

  providedIn: 'root'

})

export class AuthGuard implements CanActivate {

 

  constructor (public _authService: AuthService,

               public router: Router) {}

  canActivate(

    next: ActivatedRouteSnapshot,

    state: RouterStateSnapshot): Observable<boolean> | Promise<boolean> | boolean {

      if (!this._authService.isLoggedIn()) {

        this.router.navigate(['login']);

        return false;

      }

      return true;

  }

}