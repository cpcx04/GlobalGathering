class EventResponse {
  String? name;
  String? descripcion;
  String? url;
  double? latitud;
  double? longitud;
  double? price;
  String? createdBy;

  EventResponse(
      {this.name,
      this.descripcion,
      this.url,
      this.latitud,
      this.longitud,
      this.price,
      this.createdBy});

  EventResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    descripcion = json['descripcion'];
    url = json['url'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    price = json['price'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['descripcion'] = this.descripcion;
    data['url'] = this.url;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    data['price'] = this.price;
    data['createdBy'] = this.createdBy;
    return data;
  }
}
