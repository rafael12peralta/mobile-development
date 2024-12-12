import 'package:flutter/material.dart';
import 'package:social_food_app/api/api_service.dart';
import 'package:social_food_app/components/card2.dart';
import 'package:social_food_app/models/simple_recipe.dart';

class RecipesScreen extends StatelessWidget {
  RecipesScreen({super.key});

  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiService.getRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return RecipesGrid(recipes: snapshot.data ?? []);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class RecipesGrid extends StatelessWidget {
  const RecipesGrid({super.key, required this.recipes});

  final List<SimpleRecipe> recipes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: recipes.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final simpleRecipe = recipes[index];
        return RecipeThumbnail(simpleRecipe: simpleRecipe);
      },
    );
  }
}

class RecipeThumbnail extends StatelessWidget {
  const RecipeThumbnail({
    super.key,
    required this.simpleRecipe,
  });

  final SimpleRecipe simpleRecipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  simpleRecipe.dishImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              simpleRecipe.title,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              simpleRecipe.duration,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
