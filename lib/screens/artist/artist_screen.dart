import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/models/models.dart';
import 'package:music_app/screens/artist/artist_controller.dart';
import 'package:music_app/services/firebase_functions.dart';
import 'package:music_app/services/firebase_storage.dart';
import 'package:music_app/widgets/background.dart';
import 'package:music_app/widgets/widgets.dart';

class ArtistScreen extends GetView<ArtistController> {
  const ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Artist artist = Get.arguments;

    return Background(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CoverImage(artist: artist),
              const SizedBox(height: 10),
              Header(artist: artist),
              const SizedBox(height: 10),
              PopularSongs(artist: artist),
              const SizedBox(height: 10),
              Albums(artist: artist),
            ],
          ),
        ),
      ),
    );
  }
}

class Albums extends StatelessWidget {
  const Albums({
    Key? key,
    required this.artist,
  }) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FunctionsService.callFunction(
          'getCollectionsFromArtist', {'artistId': artist.id}),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        final data = snapshot.data!.data.map((e) => json.encode(e)) as Iterable;
        final collections = Collection.fromData(data);
        return CollectionsListView(
          title: 'Albums',
          collections: collections,
        );
      },
    );
  }
}

class PopularSongs extends StatelessWidget {
  const PopularSongs({
    Key? key,
    required this.artist,
  }) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FunctionsService.callFunction(
        'getPopularSongsFromArtist',
        {'artistId': artist.id},
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        final data = snapshot.data!.data.map((e) => json.encode(e)) as Iterable;
        final songs = Song.fromData(data);
        return SongsListView(
          title: 'Popular songs',
          songs: songs,
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.artist,
  }) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            artist.name,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w700),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.white,
              ),
              shape: const StadiumBorder(),
            ),
            child: Text(
              'Follow',
              style: Theme.of(context).textTheme.button!.copyWith(
                    fontSize: 18,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({
    Key? key,
    required this.artist,
  }) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StorageService.getDownloadUrl('artists/${artist.coverUrl}'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        String url = snapshot.data!;
        return CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => const CircularProgressIndicator(),
        );
      },
    );
  }
}
