
class Movies {
  List<Movie> items = new List();

  Movies();

  Movies.fromJsonList( List<dynamic> jsonList ){
    if ( jsonList == null ) return;

    for ( final item in jsonList ){
      final movie = new Movie.fromJsonMap( item );
      items.add( movie );
    }
  }
}

class Movie {

  String uniqueID;

  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate
  });

  Movie.fromJsonMap( Map< String, dynamic > json ){
    this.popularity     = json['popularity'] / 1;
    this.voteCount      = json['vote_count'];
    this.video          = json['video'];
    this.posterPath     = json['poster_path'];
    this.id             = json['id'];
    this.adult          = json['adult'];
    this.backdropPath   = json['backdrop_path'];
    this.originalLanguage = json['original_language'];
    this.originalTitle  = json['original_title'];
    this.genreIds       = json['genre_ids'].cast<int>();
    this.title          = json['title'];
    this.voteAverage    = json['vote_average'] / 1;
    this.overview       = json['overview'];
    this.releaseDate    = json['release_date'];
  }

  getPosterImg(){
    if ( this.posterPath == null ){
      return 'https://ctt.trains.com/sitefiles/images/no-preview-available.png';
    }
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  getBackgroundImg(){
    if ( this.posterPath == null ){
      return 'https://ctt.trains.com/sitefiles/images/no-preview-available.png';
    }
    return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }
}