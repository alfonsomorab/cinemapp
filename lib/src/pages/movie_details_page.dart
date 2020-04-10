import 'package:cinemapp/src/models/actor_model.dart';
import 'package:cinemapp/src/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:cinemapp/src/models/movie_model.dart';

class MovieDetailsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(context, movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20.0,),
                _createPosterTitle(context, movie),
                _createDescription(context, movie),
                _createActors(context, movie),
              ]
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAppBar(BuildContext context, Movie movie){

    return SliverAppBar(
      elevation: 5.0,
      backgroundColor: Colors.red,
      expandedHeight: MediaQuery.of(context).size.height * 0.25,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Text(
            movie.title,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(0.0, 1.0),
                  blurRadius: 8.0,
                  color: Colors.black87,
                ),
              ]
            ),
            overflow: TextOverflow.ellipsis,

          ),
        ),
        background: FadeInImage(
          image: NetworkImage( movie.getBackgroundImg() ),
          placeholder: AssetImage('assets/loading.gif'),
          fadeInDuration: Duration(milliseconds: 200),
          fit: BoxFit.cover,
        ),

      ),
    );

  }

  Widget _createPosterTitle(BuildContext context, Movie movie){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueID,
            child: ClipRRect(
              child: Image(
                image: NetworkImage(movie.getPosterImg()),
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          SizedBox( width: 20.0),
          Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text(movie.title,
                  maxLines: 5,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text(movie.originalTitle,
                  maxLines: 5,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.ellipsis),
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.cake),
                  Text(movie.releaseDate, style: Theme.of(context).textTheme.subhead,),
                ],
              ),

              Row(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.subhead,),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.favorite_border),
                  Text(movie.popularity.toString(), style: Theme.of(context).textTheme.subhead,),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }

  Widget _createDescription(BuildContext context, Movie movie){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.body2,
      ),
    );
  }

  Widget _createActors(BuildContext context, Movie movie){

    final movieProvider = new MoviesProvider();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 15.0),
          child: Text('Actores', style: Theme.of(context).textTheme.subhead,
          )
        ),
        SizedBox(height: 10.0,),
        FutureBuilder(
          //stream: moviesProvider.popularMoviesStream,
          future: movieProvider.getCast(movie.id.toString()),
          builder: (( BuildContext context, AsyncSnapshot<List<Actor>> snapshot ){
            if (snapshot.hasData) {

              return _createActorsPageView( snapshot.data );
            }
            else {
              return Container(
                height: 200.0,
                child: Center(
                  child: CircularProgressIndicator()
                )
              );
            }
          }),
        ),
      ],
    );
  }

  Widget _createActorsPageView(List<Actor> actors){
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        pageSnapping: false,
        itemBuilder: (BuildContext context, int index) {
          return _createCardActor(context, actors[index]);
        },
        itemCount: actors.length,
      ),
    );
  }

  Widget _createCardActor(BuildContext context, Actor actor) {

    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Column(

        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getPosterImg()),
              placeholder: AssetImage('assets/no-image.jpg'),
              height: 150.0,
              fadeInDuration: Duration(milliseconds: 200),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            style: Theme.of(context).textTheme.caption,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

}
