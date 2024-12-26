import 'package:flutter/material.dart';

class TodayExpenses extends StatelessWidget {

  const TodayExpenses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 4,
                height: 40,
                color: Colors.blue,
              ),
              const SizedBox(width: 8),
              const Text('Categoría 1'),
              const Spacer(),
              const Text('\$150.00'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 4,
                height: 40,
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              const Text('Categoría 2'),
              const Spacer(),
              const Text('\$75.50'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 4,
                height: 40,
                color: Colors.orange,
              ),
              const SizedBox(width: 8),
              const Text('Categoría 3'),
              const Spacer(),
              const Text('\$200.00'),
            ],
          ),
        ],
      ),
    );
  }
}
