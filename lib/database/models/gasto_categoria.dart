class GastoCategoria {
  final int? id;
  final String nombre;
  final int idTipo;

  GastoCategoria({this.id, required this.nombre, required this.idTipo});

  // Convertir un objeto GastoCategoria a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'id_tipo': idTipo,
    };
  }

  // Convertir un mapa a un objeto GastoCategoria
  factory GastoCategoria.fromMap(Map<String, dynamic> map) {
    return GastoCategoria(
      id: map['id'],
      nombre: map['nombre'],
      idTipo: map['id_tipo'],
    );
  }
}
