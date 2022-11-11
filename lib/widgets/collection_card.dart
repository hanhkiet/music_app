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
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CoverImage(collection: collection),
            const SizedBox(height: 5),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          collection.name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Text(
          'artists',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
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
            width: MediaQuery.of(context).size.width * .35,
            height: MediaQuery.of(context).size.width * .4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          placeholder: (context, url) => SizedBox(
            width: MediaQuery.of(context).size.width * .35,
            height: MediaQuery.of(context).size.width * .4,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
