import 'package:social_food_app/models/explore_recipe.dart';
import 'package:social_food_app/models/post.dart';

class ExploreData{

  final List<ExploreRecipe> todayRecipes;
  final List<Post> friendPosts;

  ExploreData(
      this.todayRecipes,
      this.friendPosts
      );
}