class GastoTipo {
  final int? id;
  final String nombre;

  GastoTipo({this.id, required this.nombre});

  // Convertir un objeto GastoTipo a un mapa (para inserciones en la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }

  // Convertir un mapa a un objeto GastoTipo
  factory GastoTipo.fromMap(Map<String, dynamic> map) {
    return GastoTipo(
      id: map['id'],
      nombre: map['nombre'],
    );
  }
}
