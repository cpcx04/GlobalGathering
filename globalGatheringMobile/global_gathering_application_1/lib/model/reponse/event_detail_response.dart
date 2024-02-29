class EventDetailResponse {
  String? nombre;
  String? fecha;
  String? url;
  String? ciudad;
  String? precio;
  List<Apuntados>? apuntados;

  EventDetailResponse(
      {this.nombre,
      this.fecha,
      this.url,
      this.ciudad,
      this.precio,
      this.apuntados});

  EventDetailResponse.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    fecha = json['fecha'];
    url = json['url'];
    ciudad = json['ciudad'];
    precio = json['precio'];
    if (json['apuntados'] != null) {
      apuntados = <Apuntados>[];
      json['apuntados'].forEach((v) {
        apuntados!.add(new Apuntados.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this.nombre;
    data['fecha'] = this.fecha;
    data['url'] = this.url;
    data['ciudad'] = this.ciudad;
    data['precio'] = this.precio;
    if (this.apuntados != null) {
      data['apuntados'] = this.apuntados!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Apuntados {
  String? id;
  String? username;

  Apuntados({this.id, this.username});

  Apuntados.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}
