import { Component } from '@angular/core';
import { AuthService } from '../../services/auth/auth.service';
import { Router } from '@angular/router';

@Component({
    selector: 'app-login-form',
    templateUrl: './login-form.component.html',
    styleUrls: ['./login-form.component.css']
})
export class LoginFormComponent {
    username: string = '';
    password: string = '';

    constructor(private authService: AuthService,private router:Router) {}

    login() {
        this.authService.login(this.username, this.password).subscribe(
            (response) => {
               this.router.navigate(['/home']);
            },
            (error) => {
                alert('Login failed' + error);
            }
        );
    }
}
