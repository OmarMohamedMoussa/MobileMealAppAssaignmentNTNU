import 'package:adv/models/meal.dart';
import 'package:adv/screens/meals_details.dart';
import 'package:adv/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class MealsScreen extends StatelessWidget {
  //Constructure
  const MealsScreen({super.key, this.title, required this.meals});

  //name of the title make it optinal by adding question mark
  final String? title;

  // Stores a list of the meals that is in the Meal
  final List<Meal> meals;

  // Handles on push click and return meal screen to that item
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  /// Builds the widget and stores the values as a list, only load what is visebole
  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        onSelectMeal: (meal) {
          selectMeal(context, meal);
        },
      ),
    );

    //if-statement to handle if there is no meal
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh ... nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    }

    // if loop to check if title is sett or not. This is for a better scaffold when shown in favorites
    if (title == null) {
      return content;
    }

    //else, if there is a title
    //Scaffold because its going to cover the screen
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      //Takes in a list of meals, and displays or load only the visible ones
      body: content,
    );
  }
}
