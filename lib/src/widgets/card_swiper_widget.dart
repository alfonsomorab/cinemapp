import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cinemapp/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  List<Movie> list;

  CardSwiper( { @required this.list } );

  @override
  Widget build(BuildContext context) {



    return Container(
      padding: EdgeInsets.only( top:20.0 ) ,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: MediaQuery.of(context).size.width * 0.7 ,
        itemHeight: MediaQuery.of(context).size.height * 0.5 ,
        itemBuilder: (BuildContext context,int index){

          list[index].uniqueID = '${ list[index].id }_poster';

          final card = Hero(
            tag: list[index].uniqueID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(
                  list[index].getPosterImg()
                ),
                placeholder: AssetImage('assets/loading2.gif'),
                fit: BoxFit.cover,
              ),
            ),
          );

          return GestureDetector(
            child: card,
            onTap: (){
              Navigator.pushNamed(context, 'details', arguments: list[index]);
            },
          );
        },
        itemCount: list.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
