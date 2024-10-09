import 'package:adv/models/meal.dart';
import 'package:adv/providers/favorites_provider.dart';
import 'package:adv/widgets/meal_item_trait.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealItem extends ConsumerWidget {
  //Constructor
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  // store a meal as a property
  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  // Stores enum of the complexity with uppercase front letter
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  // stores enum of affordability with big upper case
  String get affordability {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  // Builds the widget for the meals
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch if a meal is a favorite
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordability,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Adding star icon for favoriting
            Positioned(
              top: 0,
              right: 0,
              //To add radius to the button
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12), // only the left
                ),
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.all(0),
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isFavorite ? Colors.white : Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      final wasAdded = ref
                          .read(favoriteMealsProvider.notifier)
                          .toggleMealFavoriteStatus(meal);

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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
