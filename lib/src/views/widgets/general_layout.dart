import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneralPlayout extends StatelessWidget {
  const GeneralPlayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                      .15,
                      .5,
                      .6,
                      .7,
                      .8,
                      1
                    ],
                    colors: [
                      primaryWinFalDarkColor.withOpacity(1),
                      primaryWinFalDarkColor.withOpacity(1),
                      primaryWinFalDarkColor.withOpacity(0),
                      Colors.transparent,
                      primaryWinFalDarkColor.withOpacity(0),
                      primaryWinFalDarkColor.withOpacity(.8),
                      primaryWinFalDarkColor.withOpacity(1),
                      primaryWinFalDarkColor,
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
                              color: primaryWinFalExtraColor,
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
                        color: primaryWinFalExtraColor,
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
                            Text(
                              '0.47',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Spacer(),
                            Text(
                              '-1.48',
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ],
                        ),
                        SIZED_BOX_H30,
                        Row(
                          children: [
                            Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(pi),
                                child: SvgPicture.asset(
                                    'assets/icons/repeat_icon.svg',
                                    color: primaryLightBackgroundColor,
                                    height: 20)),
                            Spacer(),
                            Transform.rotate(
                              angle: -pi * 4 / 5,
                              child: SvgPicture.asset(
                                  'assets/icons/skip_icon.svg',
                                  color: primaryLightBackgroundColor,
                                  height: 20),
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              'assets/icons/previous_icon.svg',
                              color: primaryLightBackgroundColor,
                              height: 24,
                            ),
                            SIZED_BOX_W20,
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                  color: secondarySprSumDarkColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: primaryWinFalExtraDarkColor
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
                                        secondaryWinFalColor,
                                        secondaryWinFalColor,
                                        secondaryWinFalDarkColor,
                                        secondaryWinFalDarkColor
                                      ])),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/pause_icon.svg',
                                  color: primaryLightBackgroundColor,
                                  width: 28,
                                ),
                              ),
                            ),
                            SIZED_BOX_W20,
                            SvgPicture.asset('assets/icons/next_icon.svg',
                                color: primaryLightBackgroundColor, height: 24),
                            Spacer(),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(pi)
                                ..rotateZ(-pi * 4 / 5),
                              child: SvgPicture.asset(
                                  'assets/icons/skip_icon.svg',
                                  color: primaryLightBackgroundColor,
                                  height: 20),
                            ),
                            Spacer(),
                            SvgPicture.asset('assets/icons/shuffle_icon.svg',
                                color: primaryLightBackgroundColor, height: 20),
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
