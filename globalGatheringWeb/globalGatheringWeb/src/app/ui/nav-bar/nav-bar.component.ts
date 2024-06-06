import { Component, OnInit } from '@angular/core';
import { Router, NavigationEnd } from '@angular/router';
import { AuthService } from '../../services/auth/auth.service';

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.css']
})
export class NavBarComponent implements OnInit {
  nombreUsuario: string = '';
  rolUsuario: string = '';
  currentRoute: string = '';

  constructor(private router: Router, private authService: AuthService) {
    this.router.events.subscribe(event => {
      if (event instanceof NavigationEnd) {
        this.currentRoute = event.urlAfterRedirects;
      }
    });
  }

  ngOnInit(): void {
    this.nombreUsuario = localStorage.getItem('nombre') || '';
    const rol = localStorage.getItem('role') || '';
    this.rolUsuario = rol.replace('ROLE_', '');
    this.currentRoute = this.router.url;
  }

  logOut(){
    this.authService.logout();
  }
}
