import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/models/models.dart';
import 'package:music_app/models/search_result_model.dart';
import 'package:music_app/screens/search/search_controller.dart';
import 'package:music_app/services/functions.dart';
import 'package:music_app/services/search.dart';
import 'package:music_app/services/storage.dart';
import 'package:music_app/themes.dart';
import 'package:music_app/utils/convert.dart';
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
                const SearchBar(),
                const SizedBox(height: 30),
                Obx(() {
                  if (controller.query.isNotEmpty) {
                    return FutureBuilder(
                      future: SearchService().searchSongs(controller.getQuery),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        final data = snapshot.data as Iterable;
                        final results = SearchResult.fromData(data);
                        return Result(results: results);
                      },
                    );
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
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Browse',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w600,
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

// class Result extends StatelessWidget {
//   const Result({
//     Key? key,
//     Object? songs,
//     required this.results,
//   }) : super(key: key);

//   final List<SearchResult> results;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final type = results[index].resultType;
//         final id = results[index].id;
//         return Text(id);
//       },
//     );
//   }
// }

class Result extends StatelessWidget {
  const Result({
    Key? key,
    Object? songs,
    required this.results,
  }) : super(key: key);

  final List<SearchResult> results;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: results.length,
      itemBuilder: (context, index) {
        final type = results[index].resultType;
        final id = results[index].id;

        if (type == 'song') {
          return FutureBuilder(
            future: FunctionsService.callFunction('getSong', {'id': id}),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              final data = convertToJson(snapshot.data!.data);
              final song = Song.fromJson(data);

              return InkWell(
                onTap: () {
                  Get.toNamed('/song', arguments: [song]);
                },
                child: ListTile(
                  leading: CoverImage(result: results[index]),
                  title: Text(results[index].title),
                  subtitle: Text(results[index].resultType),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                  ),
                ),
              );
            },
          );
        } else if (type == 'artist') {
          return FutureBuilder(
            future: FunctionsService.callFunction('getArtist', {'id': id}),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              final data = convertToJson(snapshot.data!.data);
              final artist = Song.fromJson(data);

              return InkWell(
                onTap: () {
                  Get.toNamed('/artist', arguments: artist);
                },
                child: ListTile(
                  leading: CoverImage(result: results[index]),
                  title: Text(results[index].title),
                  subtitle: Text(results[index].resultType),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                  ),
                ),
              );
            },
          );
        }

        return FutureBuilder(
          future: FunctionsService.callFunction('getCollection', {'id': id}),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            final data = convertToJson(snapshot.data!.data);
            final collection = Song.fromJson(data);

            return InkWell(
              onTap: () {
                Get.toNamed('/collection', arguments: collection);
              },
              child: ListTile(
                leading: CoverImage(result: results[index]),
                title: Text(results[index].title),
                subtitle: Text(results[index].resultType),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({
    Key? key,
    required this.result,
  }) : super(key: key);

  final SearchResult result;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StorageService.getDownloadUrl('covers/${result.coverUrl}'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            width: 50,
            height: 50,
            color: Colors.black38,
          );
        }

        String url = snapshot.data!;
        if (url.isEmpty) return Container();

        return CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
            width: 50,
            height: 50,
            color: Colors.black38,
          ),
        );
      },
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        onChanged: (value) => controller.updateQuery(value),
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
