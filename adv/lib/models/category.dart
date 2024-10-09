import 'package:flutter/material.dart';

/// Blue print of the Category object
class Category {
  // constructure function
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange, // Default color set to orange
  });

  final String id;
  final String title;
  final Color color;
}
