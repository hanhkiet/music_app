import 'package:flutter/material.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/widgets/song_card.dart';
import 'package:music_app/widgets/widgets.dart';

class SongsListView extends StatelessWidget {
  const SongsListView({
    Key? key,
    required this.title,
    required this.songs,
  }) : super(key: key);

  final String title;
  final List<Song> songs;

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
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.width * .5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return SongCard(song: songs[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
