import { Component } from '@angular/core';
import { NgForm } from "@angular/forms/src/forms";
import { HttpModule, Http, Response } from '@angular/http';
import { Observable } from "rxjs/Observable";
import { Injectable } from '@angular/core';
import { Headers, RequestOptions } from '@angular/http';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/toPromise';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {


  constructor(private http: Http) { }

  url = "http://localhost:3000";

  people = [
    { name: "Evandro", psi: "evandro.leite@sim.serpro.gov.br" },
    { name: "Vanderlei", psi: "Vanderlei@sim.serpro.gov.br" },
    { name: "Eduardo Barreto", psi: "barreto@sim.serpro.gov.br" },
  ];

  sendZuada(form: NgForm) {
    console.log(form.value);
  }



  apiZuada(people: any): Observable<any> {
    let headers = new Headers({ 'Content-Type': 'application/json' });
    let options = new RequestOptions({ headers: headers });
    return this.http.post(this.url, people, options)
      .map(this.extractData)
      .catch(this.handleErrorObservable);
  }

  private extractData(res: Response) {
    let body = res.json();
    return body.data || {};
  }

  private handleErrorObservable(error: Response | any) {
    console.error(error.message || error);
    return Observable.throw(error.message || error);
  }


}
