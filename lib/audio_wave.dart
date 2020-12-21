library audio_wave;

import 'package:flutter/material.dart';

class AudioWaveBar {
  AudioWaveBar({this.height, this.color = Colors.red, this.radius = 0.0});

  /// [height] is the height of the bar based. It is percentage rate of widget height.
  ///
  /// If it's set to 30, then it will be 30% height from the widget height.
  ///
  /// [height] of bar must be between 0 to 100. Or There will be side effect.
  double height;

  /// [color] is the color of the bar
  Color color;

  /// [radius] is the radius of bar
  double radius;
}

class AudioWave extends StatefulWidget {
  AudioWave({
    this.height = 100,
    this.width = 200,
    this.spacing = 5,
    this.alignment = 'center',
    @required this.bars,
  });
  final List<AudioWaveBar> bars;

  /// [height] is the height of the widget.
  ///
  final double height;

  /// [width] is the width of the widget. Input the
  final double width;

  /// [spacing] is the spaces between bars.
  final double spacing;

  /// [alignment] is the alignment of bars. It can be one of 'top', 'center', 'bottom'.
  final String alignment;
  @override
  _AudioWaveState createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  @override
  Widget build(BuildContext context) {
    print(widget.bars[0].height);

    double width = (widget.width - (widget.spacing * widget.bars.length)) /
        widget.bars.length;

    return Container(
      height: widget.height,
      width: widget.width,
      child: Row(
        children: [
          Wrap(
            crossAxisAlignment: widget.alignment == 'top'
                ? WrapCrossAlignment.start
                : widget.alignment == 'bottom'
                    ? WrapCrossAlignment.end
                    : WrapCrossAlignment.center,
            spacing: widget.spacing,
            children: [
              for (final bar in widget.bars)
                Container(
                  height: bar.height * widget.height / 100,
                  width: width,
                  decoration: BoxDecoration(color: bar.color),
                ),
            ],
          )
        ],
      ),
    );
  }
}
