import '../constants/gastoFields.dart';

class GastoModel {
  int? id;
  final String tipo;
  final String categoria;
  final String monto;
  final String descripcion;
  final String fecha;
  final bool isActive;

  GastoModel({
    this.id,
    required this.tipo,
    required this.categoria,
    required this.monto,
    required this.descripcion,
    required this.fecha,
    required this.isActive,
  });

  Map<String, Object?> toJSON() => {
    GastoFields.id: id,
    GastoFields.tipo : tipo,
    GastoFields.categoria : categoria,
    GastoFields.monto : monto,
    GastoFields.descripcion : descripcion,
    GastoFields.fecha : fecha,
    GastoFields.isActive: isActive ? 1 : 0,
  };

  factory GastoModel.fromJSON(Map<String, Object?> json) => GastoModel(
    id: json[GastoFields.id] as int?,
    tipo: json[GastoFields.tipo] as String,
    categoria: json[GastoFields.categoria] as String,
    monto: json[GastoFields.monto] as String,
    descripcion: json[GastoFields.descripcion] as String,
    fecha: json[GastoFields.fecha] as String,
    isActive: json[GastoFields.isActive] == 1,
  );

  GastoModel copy({
    int? id,
    String? tipo,
    String? categoria,
    String? monto,
    String? descripcion,
    String? fecha,
    bool? isActive,
  }) => GastoModel(
    id: id ?? this.id,
    tipo: tipo ?? this.tipo,
    categoria: categoria ?? this.categoria,
    monto: monto ?? this.monto,
    descripcion: descripcion ?? this.descripcion,
    fecha: fecha ?? this.fecha,
    isActive: isActive ?? this.isActive,
  );
  
}
