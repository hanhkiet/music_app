import 'package:flutter/material.dart';
import 'package:music_app/models/collection_model.dart';
import 'package:music_app/widgets/collection_card.dart';
import 'package:music_app/widgets/section_header.dart';

class CollectionsListView extends StatelessWidget {
  const CollectionsListView({
    Key? key,
    required this.title,
    required this.collections,
  }) : super(key: key);

  final String title;
  final List<Collection> collections;

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
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: SectionHeader(title: title),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.width * .6,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              itemCount: collections.length,
              itemBuilder: (context, index) {
                return CollectionCard(collection: collections[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
