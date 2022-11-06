import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/models/collection_model.dart';
import 'package:music_app/services/firebase_storage.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard({
    super.key,
    required this.collection,
  });

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/collection', arguments: collection);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CoverImage(collection: collection),
            TitleBanner(collection: collection),
          ],
        ),
      ),
    );
  }
}

class TitleBanner extends StatelessWidget {
  const TitleBanner({
    Key? key,
    required this.collection,
  }) : super(key: key);

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * .37,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white.withOpacity(.8),
      ),
      child: Center(
        child: Text(
          collection.name,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: const Color.fromARGB(255, 0, 150, 158),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({
    Key? key,
    required this.collection,
  }) : super(key: key);

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StorageService.getDownloadUrl('covers/${collection.coverUrl}'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        String url = snapshot.data!;
        return CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
            width: MediaQuery.of(context).size.width * .4,
            height: MediaQuery.of(context).size.width * .4,
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
    );
  }
}
