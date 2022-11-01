import 'package:flutter/material.dart';
import 'package:music_app/models/collection_model.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Collection collection = Collection.collectionSamples[0];

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Playlist'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CollectionInformation(collection: collection),
                const SizedBox(height: 30),
                const PlayOrShuffleWidget(),
                SongList(collection: collection),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SongList extends StatelessWidget {
  const SongList({
    Key? key,
    required this.collection,
  }) : super(key: key);

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: collection.songs.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(
            '${index + 1}',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          title: Text(
            collection.songs[index].name,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('${collection.songs[index].description} - 02:45'),
          trailing: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        );
      },
    );
  }
}

class PlayOrShuffleWidget extends StatefulWidget {
  const PlayOrShuffleWidget({super.key});

  @override
  State<PlayOrShuffleWidget> createState() => _PlayOrShuffleWidgetState();
}

class _PlayOrShuffleWidgetState extends State<PlayOrShuffleWidget> {
  bool isPlay = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          isPlay = !isPlay;
        });
      },
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: isPlay ? 0 : width * .45,
              child: Container(
                height: 50,
                width: width * .45,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade400,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Play',
                          style: TextStyle(
                            color: isPlay ? Colors.white : Colors.blueAccent,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.play_circle,
                        color: isPlay ? Colors.white : Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Shuffle',
                          style: TextStyle(
                            color: isPlay ? Colors.blueAccent : Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.shuffle,
                        color: isPlay ? Colors.blueAccent : Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CollectionInformation extends StatelessWidget {
  const CollectionInformation({
    Key? key,
    required this.collection,
  }) : super(key: key);

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            collection.imageUrl,
            height: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.height * .3,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          collection.title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
