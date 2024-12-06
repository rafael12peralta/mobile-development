import 'package:flutter/material.dart';
import 'package:social_food_app/api/api_service.dart';
import 'package:social_food_app/components/card1.dart';
import 'package:social_food_app/components/today_recipe_listview.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  //instanciar un objeto de nuestra clase ApiService
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiService.getExploreData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            scrollDirection: Axis.vertical,
            children: [
              TodayRecipeListview(recipes: snapshot.data?.todayRecipes ?? []),
              FirendPostListView(posts: snapshot.data?.friendPosts ?? []),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    //Card1();
  }
}

class FriendPostListView extends StatelessWidget {
  const FriendPostListView({super.key, required this.friendposts});
  final List<Post> friendposts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Social Chef',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              final post = friendposts[index];
              //debemos devolver cada post
              return FriendPost(friendposts: post);
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 16,
              );
            },
            itemCount: friendposts.length)
      ],
    );
  }
}
