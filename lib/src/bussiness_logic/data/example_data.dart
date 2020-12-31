import 'package:flutter_music_player_app/src/bussiness_logic/models/song_info.dart';

class ExampleData {
  getSongMap() => {
        0: <SongInfo>[
          SongInfo(
              name: r'5 am', author: r'Ruck P, Shuko', type: SeasonSong.WINTER),
          SongInfo(
              name: r'Frozen Firs',
              author: r'goosetaf, xander., Anbuu',
              type: SeasonSong.WINTER),
          SongInfo(
              name: r'Going Back', author: r'Swørn', type: SeasonSong.WINTER)
        ],
        1: <SongInfo>[
          SongInfo(
              name: r'A Tribe Called Tenz',
              author: r'Ruck P',
              type: SeasonSong.SPRING),
          SongInfo(
              name: r'Lemon', author: r'Tom Doolie', type: SeasonSong.SPRING),
          SongInfo(
              name: r'Witch Hat',
              author: r'Sleepy Fish',
              type: SeasonSong.SPRING)
        ],
        2: <SongInfo>[
          SongInfo(
              name: r'Green Tea', author: r'Eli Way', type: SeasonSong.SUMMER),
          SongInfo(
              name: r'Metro Lines',
              author: r'Sleepy Fish',
              type: SeasonSong.SUMMER),
          SongInfo(
              name: r'Alwayshere', author: r'SwuM', type: SeasonSong.SUMMER)
        ],
        3: <SongInfo>[
          SongInfo(
              name: r'Butterfly',
              author: r'Sleepy Fish',
              type: SeasonSong.FALL),
          SongInfo(
              name: r'Under the City Stars',
              author: r'Aso, Middle School, Aviino',
              type: SeasonSong.FALL),
          SongInfo(name: r'Stay.', author: r'SwuM', type: SeasonSong.FALL)
        ],
      };
}
