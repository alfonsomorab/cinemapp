import 'package:cinemapp/src/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Movie> list;
  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  final Function nextPage;

  MovieHorizontal( { @required this.list, @required this.nextPage } );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener((){

      if ( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ){
        nextPage();
      }

    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: list.length,
        itemBuilder: (context, i) => _getCard(context, list[i])
      ),
    );
  }

  Widget _getCard( BuildContext context, Movie item){
    item.uniqueID = '${ item.id }_card';

    final card = Container(
      margin: EdgeInsets.only(right: 5.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: item.uniqueID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                image: NetworkImage(item.getPosterImg()),
                placeholder: AssetImage('assets/loading2.gif'),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.16,
                width: MediaQuery.of(context).size.width * 0.23,
              ),
            ),
          ),
          Text(
            item.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: (){
        Navigator.pushNamed( context, 'details', arguments: item );
      },
    );
  }

  List<Widget> _getCards(BuildContext context){

    return list.map( ( item ) {

      return _getCard(context, item);
    }).toList();
  }
}
