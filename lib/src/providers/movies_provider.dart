
import 'dart:async';
import 'dart:convert';

import 'package:cinemapp/src/models/actor_model.dart';
import 'package:http/http.dart' as http;
import 'package:cinemapp/src/models/movie_model.dart';

class MoviesProvider {

  String _apiKey = '83281d2664faad0cbfba5dd81273362c';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int popularPage = 0;
  bool _isLoading = false;

  List<Movie> _popularMovies = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularMoviesSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularMoviesStream => _popularStreamController.stream;

  void disposeStreams(){
    _popularStreamController?.close();
  }

  Future<List<Movie>> _processRequest(Uri url) async {
    final response = await http.get( url );
    final decodeData = json.decode( response.body );

    final movies = new Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }

  Future<List<Movie>> getNowPlaying () async {

    final url = Uri.https( _url , '3/movie/now_playing', {
      'api_key'  : _apiKey,
      'language' : _language,

    });

    return await _processRequest(url);

  }

  Future<List<Movie>> getPopular () async {

    if ( _isLoading ) return [];

    _isLoading = true;

    popularPage++;

    final url = Uri.https( _url , '3/movie/popular', {
      'api_key'   : _apiKey,
      'language'  : _language,
      'page'      : popularPage.toString()
    });

    final response = await _processRequest(url);

    _popularMovies.addAll(response);
    popularMoviesSink( _popularMovies );

    _isLoading = false;
    return response;
  }

  Future<List<Actor>> getCast (String movieID) async {

    final url = Uri.https( _url , '3/movie/$movieID/credits', {
      'api_key'  : _apiKey,
      'language' : _language,

    });

    final response = await http.get( url );
    final decodeData = json.decode( response.body );

    final cast = new Cast.fromJsonList(decodeData['cast']);

    return cast.actors;

  }

}