import 'package:flutter/material.dart';
import 'package:music_app/models/artist_model.dart';
import 'package:music_app/widgets/widgets.dart';

class ArtistListView extends StatelessWidget {
  const ArtistListView({
    Key? key,
    required this.artists,
  }) : super(key: key);

  final List<Artist> artists;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * .5,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(10),
          itemCount: artists.length,
          itemBuilder: (context, index) {
            return ArtistAvatar(artist: artists[index]);
          },
        ),
      ),
    );
  }
}
