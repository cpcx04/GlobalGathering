class AddAEvent {
  final String name;
  final String descripcion;
  final String url;
  final double latitude;
  final double longitude;
  final double price;
  final String ciudad;
  final DateTime date; // Nuevo campo para la fecha del evento

  AddAEvent({
    required this.name,
    required this.descripcion,
    required this.url,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.ciudad,
    required this.date, // Agregar el campo de fecha al constructor
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'descripcion': descripcion,
      'url': url,
      'latitude': latitude,
      'longitude': longitude,
      'price': price,
      'ciudad': ciudad,
      'date':
          date.toIso8601String(), // Convertir la fecha a una cadena ISO 8601
    };
  }
}
