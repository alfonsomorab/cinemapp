class Cast {

  List<Actor> actors = new List();

  Cast();

  Cast.fromJsonList( List<dynamic> jsonList){
    if ( jsonList == null ) return;
    print(jsonList.length);

    jsonList.forEach( ( item ) {
      final actor = Actor.fromJsonMap(item);
      actors.add(actor);
    });
  }

}



class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap( Map<String, dynamic> json){
    this.castId       = json['cast_id'];
    this.character    = json['character'];
    this.creditId     = json['credit_id'];
    this.gender       = json['gender'];
    this.id           = json['id'];
    this.name         = json['name'];
    this.order        = json['order'];
    this.profilePath  = json['profile_path'];
  }

  getPosterImg(){
    if ( this.profilePath == null ){
      return 'https://ctt.trains.com/sitefiles/images/no-preview-available.png';
    }
    return 'https://image.tmdb.org/t/p/w500$profilePath';
  }

}









