import 'package:adv/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier generic class
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  // This method changes favorit, and returns the data as boolean
  bool toggleMealFavoriteStatus(Meal meal) {
    // tells if a meal is favorite or not
    final mealsIsFavorite = state.contains(meal);

    if (mealsIsFavorite) {
      // .where gives a new list
      state = state.where((m) => m.id != meal.id).toList();

      return false;
    } else {
      // puls out all eliment stored in the list, and adds them as individual
      // to a new list
      state = [...state, meal];
      return true;
    }
  }
}

// StateNotifierProvider is optimised for data that can change
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
