import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:music_app/models/collection_model.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/screens/home/home_controller.dart';
import 'package:music_app/widgets/widgets.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Song> songSamples = Song.sampleSongs;
    List<Collection> collectionSamples = Collection.collectionSamples;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 0, 150, 158).withOpacity(.8),
              const Color.fromARGB(255, 0, 242, 255).withOpacity(.8),
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const MusicDiscover(),
              MusicCollection(songSamples: songSamples),
              Playlist(collectionSamples: collectionSamples),
            ],
          ),
        ),
      ),
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({
    Key? key,
    required this.collectionSamples,
  }) : super(key: key);

  final List<Collection> collectionSamples;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SectionHeader(title: 'Playlist'),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 15),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: collectionSamples.length,
            itemBuilder: (context, index) {
              return CollectionCard(
                collection: collectionSamples[index],
              );
            },
          ),
        ],
      ),
    );
  }
}

class MusicCollection extends StatelessWidget {
  const MusicCollection({
    Key? key,
    required this.songSamples,
  }) : super(key: key);

  final List<Song> songSamples;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 20,
        bottom: 20,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              right: 20,
            ),
            child: SectionHeader(title: 'Trending music'),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height * .27,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: songSamples.length,
              itemBuilder: (context, index) {
                return SongCard(song: songSamples[index]);
              },
            ),
          )
        ],
      ),
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
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey.shade400),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(Icons.grid_view_rounded),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
