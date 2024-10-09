import 'package:flutter/material.dart';
import 'package:adv/models/meal.dart';
import 'package:adv/widgets/meal_item.dart';
import 'package:adv/screens/meals_details.dart'; // Make sure to import your MealsDetailsScreen

// Main screen to display all available meals with sorting options.
class AllMealsScreen extends StatefulWidget {
  final List<Meal> availableMeals; // List of meals available to display.

  const AllMealsScreen({
    super.key,
    required this.availableMeals,
  });

  @override
  _AllMealsScreenState createState() => _AllMealsScreenState();
}

// Enum to define the sorting options available for the meals.
enum SortOption { duration, complexity, affordability }

// State class for AllMealsScreen.
class _AllMealsScreenState extends State<AllMealsScreen> {
  SortOption _selectedSortOption = SortOption.duration; // Default sort option.
  bool _isAscending = true; // Flag to determine the sorting order.

  // Method to sort meals based on the selected option.
  void _sortMeals() {
    setState(() {
      switch (_selectedSortOption) {
        case SortOption.duration:
          // Sort meals by duration based on the selected order (ascending/descending).
          widget.availableMeals.sort((a, b) => _isAscending
              ? a.duration.compareTo(b.duration)
              : b.duration.compareTo(a.duration));
          break;
        case SortOption.complexity:
          // Sort meals by complexity based on the selected order.
          widget.availableMeals.sort((a, b) => _isAscending
              ? a.complexity.index.compareTo(b.complexity.index)
              : b.complexity.index.compareTo(a.complexity.index));
          break;
        case SortOption.affordability:
          // Sort meals by affordability based on the selected order.
          widget.availableMeals.sort((a, b) => _isAscending
              ? a.affordability.index.compareTo(b.affordability.index)
              : b.affordability.index.compareTo(a.affordability.index));
          break;
      }
      // Toggle the sorting order for the next sort operation.
      _isAscending = !_isAscending;
    });
  }

  // Method to handle changes in the sorting option.
  void _changeSortOption(SortOption? newOption) {
    setState(() {
      // Update the selected sort option. Default to duration if null.
      _selectedSortOption = newOption ?? SortOption.duration;
    });
    // Sort the meals immediately after changing the option.
    _sortMeals();
  }

  // Method to navigate to the meal details screen.
  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsDetailsScreen(
            meal: meal), // Navigate to details with selected meal.
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Meals In App',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        actions: [
          // Dropdown button for selecting sorting options.
          DropdownButton<SortOption>(
            value: _selectedSortOption, // Current selected sort option.
            icon:
                Icon(_isAscending ? Icons.arrow_downward : Icons.arrow_upward),
            onChanged: _changeSortOption, // Update sort option when changed.
            items: [
              // Dropdown items for sorting by different criteria.
              DropdownMenuItem(
                value: SortOption.duration,
                child: Text(
                  'Sort by Duration',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
              DropdownMenuItem(
                value: SortOption.complexity,
                child: Text(
                  'Sort by Complexity',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
              DropdownMenuItem(
                value: SortOption.affordability,
                child: Text(
                  'Sort by Affordability',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.availableMeals.length, // Number of meals to display.
        itemBuilder: (ctx, index) {
          final meal = widget
              .availableMeals[index]; // Get the meal for the current index.
          return MealItem(
            meal: meal,
            onSelectMeal: (selectedMeal) {
              _selectMeal(context,
                  selectedMeal); // Navigate to meal details when a meal is selected.
            },
          );
        },
      ),
    );
  }
}
