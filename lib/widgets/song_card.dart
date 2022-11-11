import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/services/firebase_storage.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    Key? key,
    required this.song,
  }) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/song', arguments: song);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: MediaQuery.of(context).size.width * .4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CoverImage(song: song),
            const SizedBox(height: 5),
            TitleBanner(song: song),
          ],
        ),
      ),
    );
  }
}

class TitleBanner extends StatelessWidget {
  const TitleBanner({
    Key? key,
    required this.song,
  }) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          song.name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Text(
          'artists',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({
    Key? key,
    required this.song,
  }) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StorageService.getDownloadUrl('covers/${song.coverUrl}'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        String url = snapshot.data!;
        return CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
            width: MediaQuery.of(context).size.width * .35,
            height: MediaQuery.of(context).size.width * .4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          placeholder: (context, url) => SizedBox(
            width: MediaQuery.of(context).size.width * .35,
            height: MediaQuery.of(context).size.width * .4,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
