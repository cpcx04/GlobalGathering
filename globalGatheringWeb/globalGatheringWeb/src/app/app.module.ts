import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomePageComponent } from './components/home-page/home-page.component';
import { LoginFormComponent } from './ui/login-form/login-form.component';
import { HttpClientModule } from '@angular/common/http';
import { ReactiveFormsModule } from '@angular/forms';
import { FormsModule } from '@angular/forms';
import { LoginPageComponent } from './components/login-page/login-page.component';
import { HomeUiComponent } from './ui/home-ui/home-ui.component';
import { NavBarComponent } from './ui/nav-bar/nav-bar.component';
import { TableUiComponent } from './ui/table-ui/table-ui.component'; // Import FormsModule here

@NgModule({
  declarations: [
    AppComponent,
    HomePageComponent,
    LoginFormComponent,
    LoginPageComponent,
    HomeUiComponent,
    NavBarComponent,
    TableUiComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule, 
    AppRoutingModule,
    ReactiveFormsModule,
    FormsModule // Add FormsModule here
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
