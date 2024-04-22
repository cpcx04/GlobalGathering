import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth/auth.service';

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.css']
})
export class NavBarComponent implements OnInit {
  nombreUsuario: string = '';
  rolUsuario: string = '';
  isHomeRoute: boolean = false;

  constructor(private router: Router, private authService: AuthService) {}

  ngOnInit(): void {
    this.nombreUsuario = localStorage.getItem('nombre') || '';
    const rol = localStorage.getItem('role') || '';
    this.rolUsuario = rol.replace('ROLE_', '');

    this.isHomeRoute = this.router.url === '/home';
  }

  logOut(){
    this.authService.logout();
  }
  
}
