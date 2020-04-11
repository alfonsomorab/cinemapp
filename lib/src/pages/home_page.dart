import 'package:cinemapp/src/delegates/search_delegate.dart';
import 'package:cinemapp/src/models/movie_model.dart';
import 'package:cinemapp/src/providers/movies_provider.dart';
import 'package:cinemapp/src/widgets/card_swiper_widget.dart';
import 'package:cinemapp/src/widgets/movie_horizontal.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {


  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        title: Text('CinemApp'),
        backgroundColor: Colors.red,
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body : Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _createSwiper(context),
          _createFooter(context),
        ],
      ),
    );
  }

  Widget _createSwiper(BuildContext context){

    return FutureBuilder(
      future: moviesProvider.getNowPlaying(),

      builder: ((BuildContext context, AsyncSnapshot<List> snapshot){
        if (snapshot.hasData) {

          return CardSwiper(
            list : snapshot.data
          );
        }
        else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      })
    );
  }

  Widget _createFooter(BuildContext context){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 15.0),
          child: Text('Populares', style: Theme.of(context).textTheme.subhead,
          )
        ),
        SizedBox(height: 10.0,),
        StreamBuilder(
          stream: moviesProvider.popularMoviesStream,
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasData){

              return MovieHorizontal(
                list: snapshot.data,
                nextPage: moviesProvider.getPopular,
              );
            }
            else {
              return Center(child: CircularProgressIndicator());
            }
          }
        ),
      ],
    );
  }
}
