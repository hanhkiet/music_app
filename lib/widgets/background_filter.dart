import 'package:flutter/material.dart';

class BackgroundFilter extends StatelessWidget {
  const BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white.withOpacity(.5),
            Colors.white.withOpacity(0),
          ],
          stops: const [0, .3, .6],
        ).createShader(rect);
      },
      blendMode: BlendMode.xor,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 150, 158),
              Color.fromARGB(255, 0, 242, 255),
            ],
          ),
        ),
      ),
    );
  }
}
