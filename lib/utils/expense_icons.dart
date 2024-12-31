import 'package:flutter/material.dart';

/// Función para obtener el ícono según el ID del tipo de gasto
IconData getIconForExpenseType(int id) {
  switch (id) {
    case 1:
      return Icons.payments;
    case 2:
      return Icons.real_estate_agent;
    case 3:
      return Icons.business_center;
    case 4:
      return Icons.school;
    case 5:
      return Icons.monitor_heart;
    case 6:
      return Icons.sports_esports;
    case 7:
      return Icons.checkroom;
    case 8:
      return Icons.redeem;
    case 9:
      return Icons.directions_car;
    case 10:
      return Icons.devices_other;
    case 11:
      return Icons.savings;
    case 12:
      return Icons.pets;
    case 13:
      return Icons.dynamic_feed;
    default:
      return Icons.help_outline;
  }
}
  IconData getIconForExpenses(String tipo) {
    switch (tipo) {
      case '1':
        return Icons.payments;
      case '2':
        return Icons.real_estate_agent;
      case '3':
        return Icons.business_center;
      case '4':
        return Icons.school;
      case '5':
        return Icons.monitor_heart;
      case '6':
        return Icons.sports_esports;
      case '7':
        return Icons.checkroom;
      case '8':
        return Icons.redeem;
      case '9':
        return Icons.directions_car;
      case '10':
        return Icons.devices_other;
      case '11':
        return Icons.savings;
      case '12':
        return Icons.pets;
      case '13':
        return Icons.dynamic_feed;
      default:
        return Icons.help_outline; // Icono predeterminado para tipos desconocidos
    }
  }
