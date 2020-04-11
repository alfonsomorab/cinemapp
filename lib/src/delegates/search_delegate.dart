import 'package:cinemapp/src/models/movie_model.dart';
import 'package:cinemapp/src/providers/movies_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

  final moviesProvider = new MoviesProvider();

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

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.getSearchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

        if (snapshot.hasData){
          final movies = snapshot.data;

          return ListView(

            children: movies.map(( movie ){
              movie.uniqueID = '${ movie.id }_card';
              return ListTile(
                onTap: (){
                  Navigator.pushNamed(context, 'details', arguments: movie);
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),

                  child: Hero(
                    tag: movie.uniqueID,
                    child: FadeInImage(
                      width: 50.0,
                      placeholder: AssetImage('assets/loading2.gif'),
                      image: NetworkImage(movie.getPosterImg()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  movie.title,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(movie.originalTitle,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    Row(children: <Widget>[
                      Icon(Icons.star_border),
                      Text(movie.voteAverage.toString())
                    ],),
                  ],
                ),
              );
            }).toList(),
          );

        }
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      },
    );
  }

//  Other Method to example
//  @override
//  Widget buildSuggestions(BuildContext context) {
//    // some suggestions until the user writes
//    List list = new List();
//    if (query.isEmpty){
//      list = suggestedMovies;
//    }
//    else{
//      list = movies.where((p) => p.toLowerCase().contains(query.toLowerCase())).toList();
//    }
//    return ListView.builder(
//      itemCount: list.length,
//      itemBuilder: (BuildContext context, int index) {
//        return ListTile(
//          leading: Icon( Icons.local_movies ),
//          title: Text(list[index]),
//          onTap: (){},
//        );
//      },
//
//    );
//  }


}