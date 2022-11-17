import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/global/player_controller.dart';
import 'package:music_app/models/collection_model.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/screens/collection/collection_controller.dart';
import 'package:music_app/services/firebase_functions.dart';
import 'package:music_app/services/firebase_storage.dart';
import 'package:music_app/widgets/background.dart';

class CollectionScreen extends GetView<CollectionController> {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CollectionInformation(),
                SizedBox(height: 10),
                SongsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SongsList extends StatelessWidget {
  const SongsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FunctionsService.callFunction(
          'getSongsFromCollection', {"id": Get.arguments.id}),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        final data = snapshot.data!.data.map((e) => json.encode(e)) as Iterable;
        final songs = Song.fromData(data);

        return Column(
          children: [
            PlaylistPlayMode(songs: songs),
            const SizedBox(height: 10),
            SongList(songs: songs),
          ],
        );
      },
    );
  }
}

class PlaylistPlayMode extends StatelessWidget {
  const PlaylistPlayMode({
    super.key,
    required this.songs,
  });

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _playPlaylist,
            icon: const Icon(
              Icons.play_circle_fill_rounded,
              size: 35,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: _shufflePlaylist,
            icon: const Icon(
              Icons.shuffle_rounded,
              size: 35,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _shufflePlaylist() {}

  void _playPlaylist() async {
    final PlayerController controller = Get.find();
    await controller.updatePlaylist(songs);
  }
}

class SongList extends StatelessWidget {
  const SongList({
    Key? key,
    required this.songs,
  }) : super(key: key);

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.toNamed(
              '/song',
              arguments: songs[index],
            );
          },
          child: ListTile(
            leading: CoverImage(song: songs[index]),
            title: Text(
              songs[index].name,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: Text(
              'artists',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_rounded,
              ),
              color: Colors.white,
            ),
          ),
        );
      },
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
          return Container(
            width: 50,
            height: 50,
            color: Colors.black38,
          );
        }

        String url = snapshot.data!;
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

class CollectionInformation extends StatelessWidget {
  const CollectionInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Collection collection = Get.arguments;

    return Column(
      children: [
        FutureBuilder(
          future:
              StorageService.getDownloadUrl('covers/${collection.coverUrl}'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            String url = snapshot.data!;
            return CachedNetworkImage(
              imageUrl: url,
              imageBuilder: (context, imageProvider) => Container(
                width: MediaQuery.of(context).size.width * .6,
                height: MediaQuery.of(context).size.width * .6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
            );
          },
        ),
        const SizedBox(height: 30),
        Text(
          collection.name,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
