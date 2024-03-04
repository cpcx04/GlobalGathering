class AddAEvent {
  final String name;
  final String descripcion;
  final String url;
  final double latitude;
  final double longitude;
  final double price;
  final String ciudad;

  AddAEvent(
      {required this.name,
      required this.descripcion,
      required this.url,
      required this.latitude,
      required this.longitude,
      required this.price,
      required this.ciudad});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'descripcion': descripcion,
      'url': url,
      'latitude': latitude,
      'longitude': longitude,
      'price': price,
      'ciudad': ciudad
    };
  }
}
