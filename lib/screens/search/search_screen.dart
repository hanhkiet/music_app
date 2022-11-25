import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/screens/search/search_controller.dart';
import 'package:music_app/themes.dart';
import 'package:music_app/widgets/background.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Title(),
                const SizedBox(height: 15),
                SearchBar(
                  searchFieldController: controller.searchFieldController,
                ),
                const SizedBox(height: 15),
                Obx(() {
                  if (controller.showResult.value) {
                    return const SearchResult();
                  } else {
                    return const Browser();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Browser extends StatelessWidget {
  const Browser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Browse',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        const SizedBox(height: 5),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: List.generate(
            10,
            (index) => Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 200,
                height: 100,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      color: Colors.red,
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Text(
        'Search',
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.searchFieldController,
  }) : super(key: key);

  final TextEditingController searchFieldController;
  @override
  Widget build(BuildContext context) {
    final SearchController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: searchFieldController,
        onChanged: (value) {
          if (value.isEmpty) {
            controller.updateShowResult(false);
          } else {
            controller.updateShowResult(true);
          }
        },
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        style: const TextStyle(
          fontSize: 18,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          hintText: 'song, artist or playlist',
          hintStyle: TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            color: Colors.white.withOpacity(0.4),
          ),
          prefixIcon: const Icon(Icons.search_rounded),
          prefixIconColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppTheme.accent,
        ),
      ),
    );
  }
}
