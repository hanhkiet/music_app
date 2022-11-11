import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends GetView {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color.fromARGB(255, 0, 150, 158).withOpacity(.8),
            const Color.fromARGB(255, 0, 242, 255).withOpacity(.8),
          ],
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
