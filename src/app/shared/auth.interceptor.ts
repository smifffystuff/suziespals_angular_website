import {
  HttpInterceptor,
  HttpRequest,
  HttpHandler,
  HttpEvent
} from '@angular/common/http';
import { Injectable } from '@angular/core';

import { Observable, from } from 'rxjs';
import { mergeMap } from 'rxjs/operators';
import { AuthService } from '../auth/auth.service';

@Injectable()
export class AuthInerceptor implements HttpInterceptor {
  constructor(private authService: AuthService) {}

  intercept(
    req: HttpRequest<any>,
    next: HttpHandler
  ): Observable<HttpEvent<any>> {
    console.log('intercepted');
    return this.getToken().pipe(
      mergeMap((token: string) => {
        console.log('token', token);
        const modifiedReq = token
          ? req.clone({
              headers: req.headers.set('Authorization', token)
            })
          : req.clone();
        console.log(req);
        console.log(modifiedReq.headers.get('Authorization'));
        return next.handle(modifiedReq);
      })
    );
  }

  getToken(): Observable<string> {
    return from(this.authService.getToken());
  }
}
