import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/blocs/chillhop_music_player/music_player_bloc.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/blocs/chillhop_music_player_bloc.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/blocs/chillhop_position_song/position_song_cubit.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/blocs/chillhop_repeat_all_one/repeat_all_one_cubit.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/models/song_info.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/utils/constants.dart';
import 'package:flutter_music_player_app/src/views/widgets/music_effect_button.dart';
import 'package:flutter_music_player_app/src/views/widgets/music_wave.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChillhopPlayout extends StatefulWidget {
  const ChillhopPlayout(
      {Key key,
      @required this.seasonTheme,
      @required this.backgroundImage,
      @required this.playlist})
      : super(key: key);
  final Map<String, Color> seasonTheme;
  final String backgroundImage;
  final List<SongInfo> playlist;
  @override
  _ChillhopPlayoutState createState() => _ChillhopPlayoutState();
}

class _ChillhopPlayoutState extends State<ChillhopPlayout>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  MusicPlayerBloc musicBloc;

  // ICONS
  String _moreIcon = 'assets/icons/more_icon.svg';
  String _backwardIcon = 'assets/icons/backward_icon.svg';
  String _repeatAllIcon = 'assets/icons/repeat_all_icon.svg';
  String _repeatOneIcon = 'assets/icons/repeat_one_icon.svg';
  String _skipIcon = 'assets/icons/skip_icon.svg';
  String _prevIcon = 'assets/icons/previous_icon.svg';
  String _nextIcon = 'assets/icons/next_icon.svg';
  String _shuffleIcon = 'assets/icons/shuffle_icon.svg';
  String _bluetoothIcon = 'assets/icons/bluetooth_icon.svg';
  String _playlistIcon = 'assets/icons/playlist_icon.svg';

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    super.initState();
  }

  @override
  void dispose() {
    musicBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: widget.seasonTheme['bgGradientColor']));
    musicBloc = BlocProvider.of<MusicPlayerBloc>(context)
      ..setPlaylist(widget.playlist);
    String _backgroundImage = widget.backgroundImage;
    // COLORS
    Color _bgGradientColor = widget.seasonTheme['bgGradientColor'];
    Color _icTopBarColor = widget.seasonTheme['icTopBarColor'];
    Color _titleTopBarColor = widget.seasonTheme['titleTopBarColor'];
    Color _btnTextColor = widget.seasonTheme['btnTextColor'];
    Color _waveActiveColor = widget.seasonTheme['waveActiveColor'];
    Color _bgLightPlayBtnColor = widget.seasonTheme['bgLightPlayBtnColor'];
    Color _bgDarkPlayBtnColor = widget.seasonTheme['bgDarkPlayBtnColor'];

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // 3 layers stacked together
            // In the lowest layer, It contain background image
            // In the second layer, It's gradient background
            // On the of top layers, It display all info and button can interacted

            // LOWEST LAYER (ADD BACKGROUND IMAGE)
            Container(
                margin: PAD_ONLY_T12,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        fit: BoxFit.none,
                        alignment: Alignment.topCenter,
                        scale: 1.6,
                        image: AssetImage(
                          _backgroundImage,
                        )))),

            // SECOND LAYER (ADD GRADIENT)
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
                      _bgGradientColor.withOpacity(1),
                      _bgGradientColor.withOpacity(1),
                      _bgGradientColor.withOpacity(0),
                      Colors.transparent,
                      _bgGradientColor.withOpacity(0),
                      _bgGradientColor.withOpacity(1),
                      _bgGradientColor.withOpacity(1),
                      _bgGradientColor,
                    ]),
              ),
            ),

            // ON TOP LAYER (MAIN LAYER)
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
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: _titleTopBarColor),
                      )),

                      // Stack can easy to custom none-symmetrical UI
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: SvgPicture.asset(
                              _moreIcon,
                              width: 20,
                              color: _icTopBarColor,
                            ),
                          )),
                    ],
                  ),

                  // Arrow-down icon (to show list)
                  SIZED_BOX_H16,
                  Transform.rotate(
                      angle: -pi / 2,
                      child: SvgPicture.asset(
                        _backwardIcon,
                        width: 10,
                        color: _icTopBarColor,
                      )),
                  Spacer(),

                  // Display info and music player
                  BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
                    cubit: musicBloc,
                    builder: (context, state) {
                      var _currentSong =
                          musicBloc.currentSongCubit.state.counter;
                      var _duration = musicBloc.getDuration() ?? 0;
                      var _nameSong = musicBloc.getNameSong(_currentSong) ?? '';
                      var _authorSong =
                          musicBloc.getAuthorSong(_currentSong) ?? '';

                      // Handle animation
                      if (state is MusicPlayerPlaying) {
                        _animationController.forward();
                      } else if (state is MusicPlayerPausing ||
                          state is MusicPlayerCompleting) {
                        _animationController.reverse();
                      }

                      // Change state of Repeat button
                      repeatMusic(RepeatAllOneState repeat) =>
                          repeat is RepeatAll
                              ? musicBloc.repeatAllOneCubit.repeatOne()
                              : musicBloc.repeatAllOneCubit.repeatAll();

                      // Push event in Play button
                      playMusic(MusicPlayerState state) {
                        if (state is MusicPlayerInitial) {
                          musicBloc.add(MusicPlayerInStarted());
                        } else if (state is MusicPlayerPlaying) {
                          musicBloc.add(MusicPlayerInPaused());
                        } else if (state is MusicPlayerPausing) {
                          musicBloc.add(MusicPlayerInResumed());
                        }
                      }

                      return Column(
                        children: [
                          // Display name and author of song
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: _nameSong,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            color:
                                                _btnTextColor.withOpacity(1))),
                                TextSpan(
                                    text: '\n$_authorSong',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                            color: _btnTextColor, height: 2))
                              ])),
                          SIZED_BOX_H20,

                          // Cubit for update position when music play
                          BlocBuilder<PositionSongCubit, PositionSongState>(
                            cubit: musicBloc.positionSongCubit,
                            builder: (context, state) {
                              return Row(
                                children: [
                                  SizedBox(
                                    width: 64,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        musicBloc
                                            .getFormatTimer(state.position),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(color: _btnTextColor),
                                      ),
                                    ),
                                  ),
                                  MusicWave(
                                    duration: _duration,
                                    position: state.position,
                                    activeColor: _waveActiveColor,
                                    inActiveColor:
                                        _btnTextColor.withOpacity(.6),
                                  ),
                                  SizedBox(
                                    width: 64,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        musicBloc.getFormatTimer(
                                            _duration - state.position,
                                            minus: true),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(color: _btnTextColor),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                          SIZED_BOX_H30,

                          // MAIN ROW FUNCTION
                          Row(
                            children: [
                              // REPEAT BUTTON
                              // Cubit for change state of repeat button
                              BlocBuilder<RepeatAllOneCubit, RepeatAllOneState>(
                                  cubit: musicBloc.repeatAllOneCubit,
                                  builder: (context, repeat) =>
                                      MusicEffectButton(
                                        onTap: () => repeatMusic(repeat),
                                        child: SvgPicture.asset(
                                            repeat is RepeatAll
                                                ? _repeatAllIcon
                                                : _repeatOneIcon,
                                            color: _btnTextColor,
                                            height: 20),
                                        type: MusicButtonType.REPEAT,
                                      )),
                              Spacer(),

                              // PREV SKIP BUTTON
                              MusicEffectButton(
                                  onTap: () => musicBloc.add(
                                      MusicPlayerInNextPrevSkipped(
                                          skipNext: false)),
                                  child: Transform.rotate(
                                      angle: -pi * 4 / 5,
                                      child: SvgPicture.asset(_skipIcon,
                                          color: _btnTextColor, height: 20)),
                                  type: MusicButtonType.SKIP_PREV),
                              Spacer(),

                              // PREV SONG BUTTON
                              MusicEffectButton(
                                onTap: () {
                                  musicBloc.add(MusicPlayerInNextPrevSong(
                                      nextSong: false));
                                },
                                child: SvgPicture.asset(
                                  _prevIcon,
                                  color: _btnTextColor,
                                  height: 24,
                                ),
                                type: MusicButtonType.PREV_SONG,
                              ),
                              SIZED_BOX_W20,

                              // PLAY BUTTON
                              MusicEffectButton(
                                  onTap: () => playMusic(state),
                                  child: Container(
                                    width: 72,
                                    height: 72,
                                    decoration: BoxDecoration(
                                        color: _bgDarkPlayBtnColor,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: _waveActiveColor
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
                                              _bgLightPlayBtnColor,
                                              _bgLightPlayBtnColor,
                                              _bgDarkPlayBtnColor,
                                              _bgDarkPlayBtnColor
                                            ])),
                                    child: Center(
                                        child: AnimatedIcon(
                                      progress: _animationController,
                                      icon: AnimatedIcons.play_pause,
                                      size: 45,
                                      color: _btnTextColor.withOpacity(1),
                                    )),
                                  ),
                                  type: MusicButtonType.PLAY),
                              SIZED_BOX_W20,

                              // NEXT SONG BUTTON
                              MusicEffectButton(
                                onTap: () => musicBloc.add(
                                    MusicPlayerInNextPrevSong(nextSong: true)),
                                child: SvgPicture.asset(_nextIcon,
                                    color: _btnTextColor, height: 24),
                                type: MusicButtonType.NEXT_SONG,
                              ),
                              Spacer(),

                              // SKIP NEXT BUTTON
                              MusicEffectButton(
                                  onTap: () => musicBloc.add(
                                      MusicPlayerInNextPrevSkipped(
                                          skipNext: true)),
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(pi)
                                      ..rotateZ(-pi * 4 / 5),
                                    child: SvgPicture.asset(_skipIcon,
                                        color: _btnTextColor, height: 20),
                                  ),
                                  type: MusicButtonType.SKIP_NEXT),
                              Spacer(),

                              // SHUFFLE BUTTON
                              MusicEffectButton(
                                onTap: () =>
                                    musicBloc.add(MusicPlayerInShuffled()),
                                child: SvgPicture.asset(_shuffleIcon,
                                    color: _btnTextColor, height: 20),
                                type: MusicButtonType.SHUFFLE,
                              )
                            ],
                          ),
                          SIZED_BOX_H40,

                          // Playlist button and Bluetooth connection with device name (Not yet handled)
                          Row(
                            children: [
                              SvgPicture.asset(
                                _bluetoothIcon,
                                color: _btnTextColor,
                                height: 16,
                              ),
                              SIZED_BOX_W06,
                              Text(
                                'Matt\'s AirPods Pro',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: _btnTextColor),
                              ),
                              Spacer(),
                              SvgPicture.asset(
                                _playlistIcon,
                                color: _btnTextColor,
                                width: 20,
                              )
                            ],
                          )
                        ],
                      );
                    },
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
