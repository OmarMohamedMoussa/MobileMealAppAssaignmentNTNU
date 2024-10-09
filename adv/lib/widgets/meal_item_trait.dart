import 'package:flutter/material.dart';

/// This class is used as metadata for the meal items
class MealItemTrait extends StatelessWidget {
  // constructure
  const MealItemTrait({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 17, color: Colors.white),
      const SizedBox(width: 6),
      Text(label,
          style: const TextStyle(
            color: Colors.white,
          )),
    ]);
  }
}
