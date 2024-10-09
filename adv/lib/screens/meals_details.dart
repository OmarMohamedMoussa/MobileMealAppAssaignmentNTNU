import 'package:adv/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adv/providers/favorites_provider.dart';

/// The screen to display the meal
/// The meal screen that shows the ingridiens and the content of the meal
class MealsDetailsScreen extends ConsumerWidget {
  //constructer
  const MealsDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  // widgetRref to listne to providers
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch if a meal is favorite meal
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              onPressed: () {
                //gives access to notifier class
                final wasAdded = ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleMealFavoriteStatus(meal);

                // notifier message that pops up
                ScaffoldMessenger.of(context)
                    .clearSnackBars(); //Clears snack bar if there is allready one
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(wasAdded
                        ? '${meal.title} added as a favorite.'
                        : '${meal.title} removed from favorites.'),
                  ),
                );
              },
              // changes icon based on if it is in the favorite list
              icon: Icon(isFavorite ? Icons.star : Icons.star_border),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            //Meal site splitted in sections
            children: [
              Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 14),
              Text(
                'Ingridients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight
                          .bold, //overides the color and sets it to the color of the background
                    ),
              ),
              const SizedBox(height: 14),
              for (final ingridient
                  in meal.ingredients) // for loop to show all the ingridiens
                Text(
                  ingridient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground, //overides the color and sets it to the color of the background
                      ),
                ),
              const SizedBox(height: 24),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight
                          .bold, //overides the color and sets it to the color of the background
                    ),
              ),
              const SizedBox(height: 24),
              for (final steps
                  in meal.steps) // for loop to show all the ingridiens
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    steps,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground, //overides the color and sets it to the color of the background
                        ),
                  ),
                ),
            ],
          ),
        ));
  }
}
