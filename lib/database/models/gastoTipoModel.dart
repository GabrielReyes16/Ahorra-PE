import '../constants/gastoTipoFields.dart';

class GastoTipoModel {
  int? id;
  final String name;
  final bool isActive;

  GastoTipoModel({
    this.id,
    required this.name,
    required this.isActive,
  });

  Map<String, Object?> toJSON() => {
    GastoTipoFields.id: id,
    GastoTipoFields.name: name,
    GastoTipoFields.isActive: isActive ? 1 : 0,
  };

  factory GastoTipoModel.fromJSON(Map<String, Object?> json) => GastoTipoModel(
    id: json[GastoTipoFields.id] as int?,
    name: json[GastoTipoFields.name] as String,
    isActive: json[GastoTipoFields.isActive] == 1,
  );

  GastoTipoModel copy({
    int? id,
    String? name,
    bool? isActive,
  }) => GastoTipoModel(
    id: id ?? this.id,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
  );
  
}
