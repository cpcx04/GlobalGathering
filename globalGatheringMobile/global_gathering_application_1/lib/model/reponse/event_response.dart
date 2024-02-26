class EventResponse {
  String? id;
  String? name;
  String? descripcion;
  String? url;
  double? latitud;
  double? longitud;
  double? price;
  String? createdBy;
  String? ciudad;
  bool? abierto;

  EventResponse(
      {this.id,
      this.name,
      this.descripcion,
      this.url,
      this.latitud,
      this.longitud,
      this.price,
      this.createdBy,
      this.ciudad,
      this.abierto});

  EventResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    descripcion = json['descripcion'];
    url = json['url'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    price = json['price'];
    createdBy = json['createdBy'];
    ciudad = json['ciudad'];
    abierto = json['abierto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['descripcion'] = this.descripcion;
    data['url'] = this.url;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    data['price'] = this.price;
    data['createdBy'] = this.createdBy;
    data['ciudad'] = this.ciudad;
    data['abierto'] = this.abierto;
    return data;
  }
}
