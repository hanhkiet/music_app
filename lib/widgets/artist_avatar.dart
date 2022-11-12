import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/models/artist_model.dart';

class ArtistAvatar extends StatelessWidget {
  const ArtistAvatar({
    Key? key,
    required this.artist,
  }) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/artist', arguments: artist);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            CoverImage(artist: artist),
            const SizedBox(height: 10),
            ArtistName(artist: artist),
          ],
        ),
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
      future: FirebaseStorage.instance
          .ref()
          .child('artists/${artist.coverUrl}')
          .getDownloadURL(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * .15,
            height: MediaQuery.of(context).size.height * .15,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        String url = snapshot.data!;
        return CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            backgroundImage: imageProvider,
            radius: MediaQuery.of(context).size.width * .15,
          ),
          placeholder: (context, url) => SizedBox(
            width: MediaQuery.of(context).size.width * .15,
            height: MediaQuery.of(context).size.height * .15,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

class ArtistName extends StatelessWidget {
  const ArtistName({
    Key? key,
    required this.artist,
  }) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Text(
      artist.name,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
