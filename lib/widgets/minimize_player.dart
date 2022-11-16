import 'package:flutter/material.dart';

class MinimizePlayer extends StatelessWidget {
  const MinimizePlayer({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        color: Colors.red,
        child: const Center(
          child: Text('minimize player'),
        ),
      ),
    );
  }
}
