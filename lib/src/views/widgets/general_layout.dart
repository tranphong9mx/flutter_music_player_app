import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneralPlayout extends StatelessWidget {
  const GeneralPlayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                margin: PAD_ONLY_T16,
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
                      .05,
                      .15,
                      .55,
                      .6,
                      .75,
                      .8,
                      1.0
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
              padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
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
                      Row(children: [
                        
                      ],)
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
