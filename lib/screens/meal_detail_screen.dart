import 'package:flutter/material.dart';
import 'package:recipe/models/meal.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer({Widget child, double height}) {
    return Container(
      height: height,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: child,
    );
  }

  Widget buildChip(String title, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: <Widget>[
              Icon(
                value ? Icons.check : Icons.close,
              ),
              SizedBox(width: 5),
              Text(title),
            ],
          ),
        ),
        color: value ? Colors.green : Colors.red,
      ),
    );
  }

  String complexityText(Meal selectedMeal) {
    switch (selectedMeal.complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
    }
  }

  String affordabilityText(Meal selectedMeal) {
    switch (selectedMeal.affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Expensive';
        break;
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '${selectedMeal.title}',
                overflow: TextOverflow.fade,
              ),
              background: Image.network(
                selectedMeal.imageUrl,
                height: 360,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Colors.black12),
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Icon(Icons.schedule),
                              SizedBox(width: 6),
                              Text('${selectedMeal.duration} min'),
                            ]),
                            Row(children: <Widget>[
                              Icon(Icons.work),
                              SizedBox(width: 6),
                              Text(complexityText(selectedMeal)),
                            ]),
                            Row(children: <Widget>[
                              Icon(Icons.attach_money),
                              SizedBox(width: 6),
                              Text(affordabilityText(selectedMeal)),
                            ]),
                          ]),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(children: <Widget>[
                        buildChip('Gluten Free', selectedMeal.isGlutenFree),
                        buildChip('Lactose Free', selectedMeal.isLactoseFree),
                        buildChip('Vegetarian', selectedMeal.isVegetarian),
                        buildChip('Vegan', selectedMeal.isVegan),
                      ]),
                    ),
                    buildSectionTitle(context, 'Ingredients'),
                    buildContainer(
                      height: 200,
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 0),
                        itemBuilder: (context, index) => Card(
                          color: Theme.of(context).accentColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(selectedMeal.ingredients[index]),
                          ),
                        ),
                        itemCount: selectedMeal.ingredients.length,
                      ),
                    ),
                    buildSectionTitle(context, 'Steps'),
                    buildContainer(
                      height: 350,
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 0),
                        itemBuilder: (context, index) => Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                child: Text('# ${(index + 1)}'),
                              ),
                              title: Text(selectedMeal.steps[index]),
                            ),
                            Divider(),
                          ],
                        ),
                        itemCount: selectedMeal.steps.length,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: isFavorite(mealId)
            ? Icon(
                Icons.favorite,
                color: Colors.red[600],
              )
            : Icon(Icons.favorite_border),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}
