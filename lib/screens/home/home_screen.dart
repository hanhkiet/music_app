import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:music_app/models/models.dart';
import 'package:music_app/screens/home/home_controller.dart';
import 'package:music_app/services/firebase_functions.dart';
import 'package:music_app/widgets/widgets.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              MusicDiscover(),
              TrendingSongsSection(),
              TopArtistsSection(),
              TopPlaylistsSection(),
              SizedBox(height: 60),
            ],
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
      future: FunctionsService.callFunction('getTopCollections', {}),
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
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: SectionHeader(title: 'Top artists'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * .5,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                itemCount: artists.length,
                itemBuilder: (context, index) {
                  return ArtistAvatar(artist: artists[index]);
                },
              ),
            )
          ],
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
                .headline5!
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
