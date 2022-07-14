library audio_wave;

import 'dart:async';

import 'package:flutter/material.dart';

class AudioWaveBar {
  AudioWaveBar({
    required this.heightFactor,
    this.color = Colors.red,
    this.radius = 50.0,
    this.gradient,
  })  : assert(heightFactor <= 1),
        assert(heightFactor >= 0);

  /// [heightFactor] is the height of the bar based. It is percentage rate of widget height.
  ///
  /// If it's set to 0.5, then it will be 50% height from the widget height.
  ///
  /// [heightFactor] of bar must be between 0 to 1. Or There will be side effect.
  double heightFactor;

  /// [color] is the color of the bar
  Color color;

  /// [radius] is the radius of bar
  double radius;

  /// [gradient] is the gradient of bar
  final Gradient? gradient;
}

class AudioWave extends StatefulWidget {
  const AudioWave(
      {required this.bars,
      this.height = 100,
      this.width = 200,
      this.spacing = 5,
      this.alignment = 'center',
      this.animation = true,
      this.animationLoop = 0,
      this.beatRate = const Duration(milliseconds: 200),
      Key? key})
      : super(key: key);
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

  /// [animation] if it is set to true, then the bar will be animated.
  final bool animation;

  /// [animationLoop] limits no of loops. If it is set to 0, then it loops forever. default is 0.
  final int animationLoop;

  /// [beatRate] plays how fast/slow the bar animates.
  final Duration beatRate;

  @override
  _AudioWaveState createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  int countBeat = 0;

  List<AudioWaveBar>? bars;

  @override
  void initState() {
    super.initState();
    if (widget.animation) {
      bars = [];

      WidgetsBinding.instance?.addPostFrameCallback((x) {
        Timer.periodic(widget.beatRate, (timer) {
          int mo = countBeat % widget.bars.length;

          bars = List.from(widget.bars.getRange(0, mo + 1));
          if (mounted) setState(() {});
          countBeat++;

          if (widget.animationLoop > 0 &&
              widget.animationLoop <= (countBeat / widget.bars.length)) {
            timer.cancel();
          }
        });
      });
    } else {
      bars = widget.bars;
    }
  }

  @override
  void didUpdateWidget(AudioWave oldWidget) {
    super.didUpdateWidget(oldWidget);
    bars = widget.bars;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = (widget.width - (widget.spacing * widget.bars.length)) /
        widget.bars.length;

    return SizedBox(
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
              if (bars != null)
                for (final bar in bars!)
                  Container(
                    height: bar.heightFactor * widget.height,
                    width: width,
                    decoration: BoxDecoration(
                      gradient: bar.gradient,
                      color: bar.color,
                      borderRadius: BorderRadius.circular(bar.radius),
                    ),
                  ),
            ],
          )
        ],
      ),
    );
  }
}
