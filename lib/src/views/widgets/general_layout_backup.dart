import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/utils/constants.dart';
import 'package:flutter_music_player_app/src/views/widgets/music_wave.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Use setState to update state (Original version)
class GeneralPlayout extends StatefulWidget {
  const GeneralPlayout({Key key}) : super(key: key);

  @override
  _GeneralPlayoutState createState() => _GeneralPlayoutState();
}

class _GeneralPlayoutState extends State<GeneralPlayout>
    with TickerProviderStateMixin {
  bool _playing;
  AudioPlayer _player;
  AudioCache _cache;
  AnimationController _animationController;
  final _playList = <String>[
    'audio/chillhop_winter/5 am.mp3',
    'audio/chillhop_winter/Ocean View.mp3',
    'audio/chillhop_winter/Frozen Firs.mp3'
  ];
  int _position;
  int _duration;
  int _currentSong = 0;
  bool _repeatAllOrOne = true;

  @override
  void initState() {
    _player = AudioPlayer();
    _cache = AudioCache(fixedPlayer: _player);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));

    if (Platform.isIOS) {
      if (_cache.fixedPlayer != null) {
        _cache.fixedPlayer.startHeadlessService();
      }
    }
    _player.onPlayerStateChanged.listen((event) {
      debugPrint(event.toString());
      switch (event) {
        case AudioPlayerState.PLAYING:
          _animationController.forward();
          break;
        case AudioPlayerState.COMPLETED:
          setState(() {
            if (_repeatAllOrOne) ++_currentSong;
          });
          _animationController.reverse();
          resetAll();
          break;
        default:
          _animationController.reverse();
          break;
      }
    });
    _player.onAudioPositionChanged.listen((event) {
      setState(() => _position = event.inSeconds);
    });

    // getDuration after set all AudioPlayer to avoid error
    resetAll();
  }

  Future<int> _getDuration(String fileUrl) async {
    File audio = await _cache.load(fileUrl);
    _player.setUrl(audio.path);
    // Return duration as milliseconds
    return ((await Future.delayed(
                Duration(milliseconds: 300), () => _player.getDuration())) /
            1000)
        .floor();
  }

  _getFormatTimer(int timer) =>
      '${(timer / 60).floor().toString().padLeft(2, '0')}.${(timer % 60).toString().padLeft(2, '0')}';

  playMusic(fileUrl) {
    if (!_playing) {
      _cache.play(fileUrl);
    } else {
      _player.pause();
    }
    setState(() => _playing = !_playing);
  }

  resetAll() async {
    setState(() {
      _duration = 0;
      _position = 0;
      _playing = false;
    });
    _getDuration(_playList[_currentSong % _playList.length])
        .then((value) => setState(() => _duration = value));
    await Future.delayed(Duration(milliseconds: 600));
    playMusic(_playList[_currentSong % _playList.length]);
  }

  previousMusic() {
    setState(() {
      if (_currentSong > 0) --_currentSong;
    });
    _player.stop();
    resetAll();
  }

  nextMusic() {
    setState(() {
      ++_currentSong;
    });
    _player.stop();
    resetAll();
  }

  previousSkipMusic(int seconds) => _player
      .seek(Duration(seconds: _position >= seconds ? _position - seconds : 0));

  nextSkipMusic(int seconds) => _player.seek(Duration(
      seconds:
          _position <= (_duration - 10) ? _position + seconds : _duration));

  shuffleMusic() => _playList.shuffle();

  repeatMusic() {
    setState(() {
      _repeatAllOrOne = !_repeatAllOrOne;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                margin: PAD_ONLY_T12,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        fit: BoxFit.none,
                        alignment: Alignment.topCenter,
                        scale: 1.6,
                        image: AssetImage(
                          'assets/images/chillhop_winter.png',
                        )))),
            Container(
              decoration: BoxDecoration(
                color: primaryLightTextColor,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    stops: [
                      0,
                      .02,
                      .12,
                      .55,
                      .6,
                      .7,
                      .8,
                      1
                    ],
                    colors: [
                      chillhopWinFalDarkColor.withOpacity(1),
                      chillhopWinFalDarkColor.withOpacity(1),
                      chillhopWinFalDarkColor.withOpacity(0),
                      Colors.transparent,
                      chillhopWinFalDarkColor.withOpacity(0),
                      chillhopWinFalDarkColor.withOpacity(1),
                      chillhopWinFalDarkColor.withOpacity(1),
                      chillhopWinFalDarkColor,
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Center(
                          child: Text(
                        'Chillhop Essentials Winter 2020',
                        style: Theme.of(context).textTheme.bodyText1,
                      )),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: SvgPicture.asset(
                              'assets/icons/more_icon.svg',
                              width: 20,
                              color: chillhopWinFalExtraColor,
                            ),
                          )),
                    ],
                  ),
                  SIZED_BOX_H16,
                  Transform.rotate(
                      angle: -pi / 2,
                      child: SvgPicture.asset(
                        'assets/icons/backward_icon.svg',
                        width: 10,
                        color: chillhopWinFalExtraColor,
                      )),
                  Spacer(),
                  Container(
                    child: Column(
                      children: [
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Snowstalgia',
                                  style: Theme.of(context).textTheme.headline6),
                              TextSpan(
                                  text: '\ninvention',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(height: 2))
                            ])),
                        SIZED_BOX_H20,
                        Row(
                          children: [
                            SizedBox(
                              width: 64,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _getFormatTimer(_position),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                            ),
                            MusicWave(
                              duration: _duration,
                              position: _position,
                            ),
                            SizedBox(
                              width: 64,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '-${_getFormatTimer(_duration - _position)}',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                            )
                          ],
                        ),
                        SIZED_BOX_H30,
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => repeatMusic(),
                              child: SvgPicture.asset(
                                  _repeatAllOrOne
                                      ? 'assets/icons/repeat_all_icon.svg'
                                      : 'assets/icons/repeat_one_icon.svg',
                                  color: primaryLightBackgroundColor,
                                  height: 20),
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: () => previousSkipMusic(10),
                                child: Transform.rotate(
                                  angle: -pi * 4 / 5,
                                  child: SvgPicture.asset(
                                      'assets/icons/skip_icon.svg',
                                      color: primaryLightBackgroundColor,
                                      height: 20),
                                )),
                            Spacer(),
                            GestureDetector(
                              onTap: () => previousMusic(),
                              child: SvgPicture.asset(
                                'assets/icons/previous_icon.svg',
                                color: primaryLightBackgroundColor,
                                height: 24,
                              ),
                            ),
                            SIZED_BOX_W20,
                            GestureDetector(
                                onTap: () => playMusic(
                                    _playList[_currentSong % _playList.length]),
                                child: Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                      color: chillhopSprSumDarkColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: chillhopWinFalExtraDarkColor
                                                .withOpacity(.8),
                                            offset: Offset(0, 10),
                                            blurRadius: 20)
                                      ],
                                      gradient: LinearGradient(
                                          begin: FractionalOffset.topRight,
                                          end: FractionalOffset.bottomLeft,
                                          stops: [
                                            0,
                                            .15,
                                            .6,
                                            1
                                          ],
                                          colors: [
                                            chillhopWinFalColor,
                                            chillhopWinFalColor,
                                            chillhopWinFalDarkColor,
                                            chillhopWinFalDarkColor
                                          ])),
                                  child: Center(
                                      child: AnimatedIcon(
                                    progress: _animationController,
                                    icon: AnimatedIcons.play_pause,
                                    size: 40,
                                    color: primaryLightBackgroundColor,
                                  )),
                                )),
                            SIZED_BOX_W20,
                            GestureDetector(
                              onTap: () => nextMusic(),
                              child: SvgPicture.asset(
                                  'assets/icons/next_icon.svg',
                                  color: primaryLightBackgroundColor,
                                  height: 24),
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: () => nextSkipMusic(10),
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(pi)
                                    ..rotateZ(-pi * 4 / 5),
                                  child: SvgPicture.asset(
                                      'assets/icons/skip_icon.svg',
                                      color: primaryLightBackgroundColor,
                                      height: 20),
                                )),
                            Spacer(),
                            GestureDetector(
                              onTap: () => shuffleMusic(),
                              child: SvgPicture.asset(
                                  'assets/icons/shuffle_icon.svg',
                                  color: primaryLightBackgroundColor,
                                  height: 20),
                            ),
                          ],
                        ),
                        SIZED_BOX_H40,
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/bluetooth_icon.svg',
                              color: primaryLightBackgroundColor,
                              height: 16,
                            ),
                            SIZED_BOX_W06,
                            Text(
                              'Matt\'s AirPods Pro',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              'assets/icons/playlist_icon.svg',
                              color: primaryLightBackgroundColor,
                              width: 20,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
