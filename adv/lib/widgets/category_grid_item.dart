import 'package:adv/models/category.dart';
import 'package:flutter/material.dart';

/// This class takes in catagories objects and stores them as a widget
class CategoryGridItem extends StatelessWidget {
  /// Constructer
  const CategoryGridItem({
    super.key,
    required this.category, //Takes in a category
    required this.onSelectCategory,
  });

  final Category category;

  // For cross screen navigation
  final void Function() onSelectCategory;

  /// builds the widget
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // tappebole widget
      onTap: onSelectCategory,
      splashColor: Theme.of(context)
          .primaryColor, //Takes in the color of the widget as an effect
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface, // changed onBackground, to onSurface
              ),
        ),
      ),
    );
  }
}
