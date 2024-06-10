export interface Events {
  id: string;
  name: string;
  descripcion: string;
  url: string;
  latitud: number;
  longitud: number;
  price: number;
  createdBy: string;
  ciudad: string;
  date: string;
}

export interface AddEventDto{
  name : string,
  descripcion: string,
  url: string,
  latitude: number,
  longitude: number,
  price : number,
  ciudad : string,
  date : string,
}
