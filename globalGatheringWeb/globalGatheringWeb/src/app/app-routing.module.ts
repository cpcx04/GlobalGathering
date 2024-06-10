import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomePageComponent } from './components/home-page/home-page.component';
import { LoginPageComponent } from './components/login-page/login-page.component';
import { AuthGuard } from './services/auth/auth.guard';
import { EventsPageComponent } from './components/events-page/events-page.component';
import { CommentsPageComponent } from './components/comments-page/comments-page.component';
import { PostPageComponent } from './components/post-page/post-page.component';

const routes: Routes = [
  { path: 'login', component: LoginPageComponent },
  { path: 'home', component: HomePageComponent, canActivate: [AuthGuard] },
  { path : 'events' , component: EventsPageComponent,canActivate: [AuthGuard]},
  {path: 'comments',component: CommentsPageComponent,canActivate: [AuthGuard]},
  {path:'posts',component: PostPageComponent,canActivate:[AuthGuard]},
  { path: '', redirectTo: '/home', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
