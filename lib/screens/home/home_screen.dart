import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:music_app/models/models.dart';
import 'package:music_app/screens/home/home_controller.dart';
import 'package:music_app/services/firebase_functions.dart';
import 'package:music_app/widgets/artist_listview.dart';
import 'package:music_app/widgets/background.dart';
import 'package:music_app/widgets/widgets.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                MusicDiscover(),
                TrendingSongsSection(),
                TopArtistsSection(),
                TopPlaylistsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TrendingSongsSection extends StatelessWidget {
  const TrendingSongsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FunctionsService.callFunction('getTrendingSongs', {}),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        final data = snapshot.data!.data.map((e) => json.encode(e)) as Iterable;
        final songs = Song.fromData(data);
        return SongsListView(
          title: 'Trending songs',
          songs: songs,
        );
      },
    );
  }
}

class TopPlaylistsSection extends StatelessWidget {
  const TopPlaylistsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FunctionsService.callFunction('getPopularCollections', {}),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        final data = snapshot.data!.data.map((e) => json.encode(e)) as Iterable;
        final collections = Collection.fromData(data);
        return CollectionsListView(
          title: 'Top playlists',
          collections: collections,
        );
      },
    );
  }
}

class TopArtistsSection extends StatelessWidget {
  const TopArtistsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FunctionsService.callFunction('getTopArtists', {}),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        final data = snapshot.data!.data.map((e) => json.encode(e));
        final artists = Artist.fromData(data);

        return Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: SectionHeader(title: 'Top artists'),
              ),
              ArtistListView(artists: artists)
            ],
          ),
        );
      },
    );
  }
}

class MusicDiscover extends StatelessWidget {
  const MusicDiscover({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 5),
          Text(
            'Enjoy your favorite music',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          // TextFormField(
          //   decoration: InputDecoration(
          //     filled: true,
          //     fillColor: Colors.white,
          //     hintText: 'Search',
          //     hintStyle: Theme.of(context)
          //         .textTheme
          //         .bodyMedium!
          //         .copyWith(color: Colors.grey.shade400),
          //     prefixIcon: const Icon(Icons.search),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(15),
          //       borderSide: BorderSide.none,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
