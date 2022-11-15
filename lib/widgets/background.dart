import 'package:flutter/material.dart';
import 'package:music_app/themes.dart';

class Background extends StatelessWidget {
  const Background({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.gradient,
      ),
      child: child,
    );
  }
}
