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
  String? date;

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
      this.abierto,
      this.date});

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
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['descripcion'] = descripcion;
    data['url'] = url;
    data['latitud'] = latitud;
    data['longitud'] = longitud;
    data['price'] = price;
    data['createdBy'] = createdBy;
    data['ciudad'] = ciudad;
    data['abierto'] = abierto;
    data['date'] = date;
    return data;
  }
}
