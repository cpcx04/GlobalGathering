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
import { TableUiComponent } from './ui/table-clients-ui/table-ui.component';
import { TableEventsUiComponent } from './ui/table-events-ui/table-events-ui.component';
import { EventsPageComponent } from './components/events-page/events-page.component';

@NgModule({
  declarations: [
    AppComponent,
    HomePageComponent,
    LoginFormComponent,
    LoginPageComponent,
    HomeUiComponent,
    NavBarComponent,
    TableUiComponent,
    TableEventsUiComponent,
    EventsPageComponent,
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
