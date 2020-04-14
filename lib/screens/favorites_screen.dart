import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  final Function isFavorite;

  FavoritesScreen(this.favoriteMeals, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty)
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    else
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            title: favoriteMeals[index].title,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            complexity: favoriteMeals[index].complexity,
            affordability: favoriteMeals[index].affordability,
            favoriteIcon: isFavorite(favoriteMeals[index].id)
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : Icon(Icons.favorite_border),
          );
        },
        itemCount: favoriteMeals.length,
      );
  }
}
