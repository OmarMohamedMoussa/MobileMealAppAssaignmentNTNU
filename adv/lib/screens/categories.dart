import 'package:adv/data/dummy_data.dart';
import 'package:adv/models/category.dart';
import 'package:adv/models/meal.dart';
import 'package:adv/screens/meals.dart';
import 'package:adv/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

/// Class that contains the catagories, extends Steless widget
/// because no internal state that would need to be managed
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  // Meals that is in the list, and not filtered away
  final List<Meal> availableMeals;

  /// Loads data from the selected categori
  // pushing the meals up (screen stacks) push and pop
  void _selectCategory(BuildContext context, Category category) {
    //Only shows meals that matches a certan condition, in this case category id
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  // building the widget
  @override
  Widget build(BuildContext context) {
    // Using scaffold for default styling
    // Important to set the navbar and other components right on,
    // inside of the app.
    return GridView(
      // adding different catagories in the app, in a grid view
      padding: const EdgeInsets.all(24),
      // chose how many catagories is in the with
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
