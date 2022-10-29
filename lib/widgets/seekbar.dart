import 'dart:math';

import 'package:flutter/material.dart';

class SeekBarData {
  final Duration position;
  final Duration duration;

  SeekBarData(this.position, this.duration);
}

class SeekBar extends StatefulWidget {
  const SeekBar(
      {super.key,
      required this.duration,
      required this.position,
      this.onChanged,
      this.onChangedEnd});

  final Duration duration;
  final Duration position;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangedEnd;

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  double? _draggingValue;

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '--:--';
    } else {
      String minutes = duration.inMinutes.toString().padLeft(2, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _draggingValue != null
            ? Text(
                _formatDuration(
                    Duration(milliseconds: _draggingValue!.toInt())),
              )
            : const Text(''),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(_formatDuration(widget.position)),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(
                    disabledThumbRadius: 4,
                    enabledThumbRadius: 4,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 10,
                  ),
                  activeTrackColor: Colors.white.withOpacity(.2),
                  inactiveTrackColor: Colors.white,
                  thumbColor: Colors.white,
                  overlayColor: Colors.white,
                ),
                child: Slider(
                  min: 0.0,
                  max: widget.duration.inMilliseconds.toDouble(),
                  value: _draggingValue ??
                      min(
                        _dragValue ?? widget.position.inMilliseconds.toDouble(),
                        widget.position.inMilliseconds.toDouble(),
                      ),
                  onChanged: (value) {
                    setState(() {
                      _draggingValue = value;
                    });
                  },
                  onChangeEnd: (value) {
                    setState(() {
                      _dragValue = value;
                    });

                    if (widget.onChangedEnd != null) {
                      widget.onChangedEnd!(
                        Duration(
                          milliseconds: value.round(),
                        ),
                      );
                    }

                    _dragValue = null;
                    _draggingValue = null;
                  },
                ),
              ),
            ),
            Text(_formatDuration(widget.duration)),
          ],
        ),
      ],
    );
  }
}
