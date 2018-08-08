import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ProfilesComponent } from './profiles/profiles.component';
import { CommunityComponent } from './community/community.component';
import { ProfileStartComponent } from './profiles/profile-start/profile-start.component';
import { ProfileDetailComponent } from './profiles/profile-detail/profile-detail.component';
import { ProfileEditComponent } from './profiles/profile-edit/profile-edit.component';
import { SignupComponent } from './auth/signup/signup.component';
import { SigninComponent } from './auth/signin/signin.component';

const appRoutes: Routes = [
  { path: '', redirectTo: '/community', pathMatch: 'full' },
  {
    path: 'profiles',
    component: ProfilesComponent,
    children: [
      { path: '', component: ProfileStartComponent },
      { path: 'new', component: ProfileEditComponent },
      { path: ':id', component: ProfileDetailComponent },
      { path: ':id/edit', component: ProfileEditComponent }
    ]
  },
  { path: 'community', component: CommunityComponent },
  { path: 'signup', component: SignupComponent },
  { path: 'signin', component: SigninComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(appRoutes)],
  exports: [RouterModule]
})
export class AppRoutingModule {}