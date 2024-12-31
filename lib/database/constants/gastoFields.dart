class GastoFields {
  static const List<String> values = [
    id,
    tipo,
    categoria,
    monto,
    descripcion,
    fecha,
    isActive,
  ];

  static const String tableName = 'gasto';

  // Campos de la tabla
  static const String id = 'id';
  static const String tipo = 'tipo';
  static const String categoria = 'categoria';
  static const String monto = 'monto';
  static const String descripcion = 'descripcion';
  static const String fecha = 'fecha';
  static const String isActive = 'isActive';
}
