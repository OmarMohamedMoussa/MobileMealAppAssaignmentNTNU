import 'package:adv/providers/favorites_provider.dart';
import 'package:adv/providers/filters_provider.dart';
import 'package:adv/screens/all_meals.dart';
import 'package:adv/screens/categories.dart';
import 'package:adv/screens/filters.dart';
import 'package:adv/screens/meals.dart';
import 'package:adv/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// global variable
const kInitialFIlters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

//tabs navigator require its own screen
/// extends ConsumberStateful using riverpod, to listen to changes done in the
/// class
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  // Function to set the screen based on command from the draw bar and closes it
  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // closes the navbardrawer
    if (identifier == 'filters') {
      // ads filter resaults as a filter map, and a boolaen value
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  //Method to select the page
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // for loop to activate right screen when the right tab is selected
  @override
  Widget build(BuildContext context) {
    //Checks meal for different type of filters, and exclude them if they have it
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      // creating a new watcher that checks state
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals, //list that contains favorite meals
      ); //No need to sett the title
      activePageTitle = 'Your Favorites';
    } else if (_selectedPageIndex == 2) {
      // Navigate to the new all meals screen
      activePage = AllMealsScreen(availableMeals: availableMeals);
      activePageTitle = 'All Meals';
    }

    // start of scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ), // sets screen based on string value from side bar
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        //The bottom navigationbar
        onTap: _selectPage,
        currentIndex: _selectedPageIndex, // controles which tab is highlated
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank),
              label: 'All Meals'), // New tab for All Meals
        ],
      ),
    );
  }
}
