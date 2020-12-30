class SongInfo {
  String _name, _author;
  SeasonSong _type;
  SongInfo({String name, String author, SeasonSong type = SeasonSong.SPRING})
      : assert(name != null),
        assert(type != null),
        assert(author != null),
        this._name = name,
        this._type = type,
        this._author = author;

  SeasonSong get getType => this._type;
  String get getName => this._name;
  String get getAuthor => this._author;

  set setName(String name) => this._name = name;
  set setAuthor(String author) => this._author = author;
  set setType(SeasonSong type) => this._type = type;
}

enum SeasonSong { SPRING, SUMMER, FALL, WINTER }
