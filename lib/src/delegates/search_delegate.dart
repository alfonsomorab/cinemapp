import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{
  // temporal lists
  final movies = [
    'Ironman',
    'Ironman 2',
    'Ironman 3',
    'Ironman 4',
    'Ironman 5',
    'Superman',
    'Aquaman',
    'Shazam',
    'Capitan America',
    'Capitana Marvel',
    'Black panter',
    'Thor',
    'Thor Ragnarok',
    'The Incredible Hulk',
    'Marvel\'s The Avengers',
  ];

  final suggestedMovies = [
    'Captain America: The Winter Soldier',
    'Captain America: Civil War	',
    'Guardians of the Galaxy	'
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
    // Right icons

    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: (){
          //print('cancel');
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Left icons

    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        //print('back');
        close( context , null );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // List of results

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // some suggestions until the user writes
    List list = new List();
    if (query.isEmpty){
      list = suggestedMovies;
    }
    else{
      list = movies.where((p) => p.toLowerCase().contains(query.toLowerCase())).toList();
    }
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon( Icons.local_movies ),
          title: Text(list[index]),
          onTap: (){},
        );
      },

    );
  }


}