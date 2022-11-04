import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/artist_model.dart';

class ArtistAvatar extends StatelessWidget {
  const ArtistAvatar({
    Key? key,
    required this.artist,
  }) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance
          .ref()
          .child('artists/${artist.coverUrl}')
          .getDownloadURL(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        String url = snapshot.data!;
        return CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: MediaQuery.of(context).size.width * .2,
                ),
              ),
              Text(artist.name),
            ],
          ),
          placeholder: (context, url) => const CircularProgressIndicator(),
        );
      },
    );
  }
}
