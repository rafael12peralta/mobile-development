import 'package:flutter/material.dart';
import 'package:social_food_app/components/author_card.dart';
import 'package:social_food_app/food_theme.dart';
import 'package:social_food_app/models/explore_data.dart';

import '../models/explore_recipe.dart';


class Card2 extends StatelessWidget {
  const Card2({super.key, required this.recipe});

  final ExploreRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.expand(width: 350, height: 450),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(recipe.backgroundImage),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            AuthorCard(
              authorName: recipe.authorName,
              title: recipe.title,
              imageProvider: AssetImage(recipe.authorImage),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Text(
                      recipe.title,
                      style: FoodTheme.lightTextTheme.displayLarge,
                    ),
                  ),
                  Positioned(
                    bottom: 70,
                    left: 16,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        recipe.subtitle,
                        style: FoodTheme.lightTextTheme.displayLarge,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
