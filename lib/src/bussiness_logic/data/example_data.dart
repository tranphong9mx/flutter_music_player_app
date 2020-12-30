import 'package:flutter_music_player_app/src/bussiness_logic/models/song_info.dart';

class ExampleData {
  getSongInfo() => <SongInfo>[
        SongInfo(
            name: '5 am', author: r'Ruck P, Shuko', type: SeasonSong.WINTER),
        SongInfo(
            name: 'Frozen Firs',
            author: r'goosetaf, xander., Anbuu',
            type: SeasonSong.WINTER),
        SongInfo(name: 'Going Back', author: r'Swørn', type: SeasonSong.WINTER)
      ];
}
