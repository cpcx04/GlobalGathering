import { Component } from '@angular/core';
import { AuthService } from '../../services/auth.service';
import { FormGroup, FormControl } from '@angular/forms';

@Component({
  selector: 'app-login-form',
  templateUrl: './login-form.component.html',
  styleUrls: ['./login-form.component.css']
})
export class LoginFormComponent {
    constructor(private loginService: AuthService){}

    loginForm = new FormGroup({
      username: new FormControl(''),
      password: new FormControl(''),
    });

    onSubmit(): void {
      const username = this.loginForm.get('username')?.value;
      const password = this.loginForm.get('password')?.value;
  
      if (username && password) {
          this.loginService.login(username, password).subscribe(
              (resp: any) => {
                alert('Login successful');
              },
              error => {
                alert('Something went wrong');
              }
          );
      } else {
          console.error('Username and/or password are invalid');
      }
      this.loginForm.reset()
    }
}
