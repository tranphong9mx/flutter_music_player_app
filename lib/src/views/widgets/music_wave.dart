import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/utils/constants.dart';

class MusicWave extends StatefulWidget {
  MusicWave(
      {Key key,
      this.duration = 0,
      this.position = 0,
      this.activeColor = primaryWinFalExtraDarkColor,
      this.inActiveColor = primaryLightBackgroundColor})
      : super(key: key);

  final int duration, position;
  final Color activeColor, inActiveColor;
  @override
  _MusicWaveState createState() => _MusicWaveState();
}

class _MusicWaveState extends State<MusicWave> {
  final List<double> _listWave = [
    6,
    10,
    24,
    40,
    18,
    30,
    24,
    40,
    18,
    28,
    22,
    40,
    20,
    24,
    16,
    40,
    16,
    30,
    20,
    40,
    26,
    24,
    18,
    40,
    14,
    24,
    20,
    40,
    16,
    30,
    16,
    6
  ];
  getNumberWaveActive() => widget.duration > 0
      ? (widget.position * _listWave.length / widget.duration).floor()
      : 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _listWave
                .asMap()
                .entries
                .map((wave) => CustomPaint(
                    painter: ShapePainter(
                        waveHeight: wave.value,
                        color: wave.key < getNumberWaveActive()
                            ? widget.activeColor
                            : widget.inActiveColor)))
                .toList()));
  }
}

class ShapePainter extends CustomPainter {
  final double waveHeight;
  final double waveWidth;
  final Color color;
  ShapePainter(
      {this.waveHeight = 10,
      this.waveWidth = 3,
      this.color = primaryLightBackgroundColor});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawRect(
        Rect.fromCenter(center: center, height: waveHeight, width: waveWidth),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
