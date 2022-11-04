import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:music_app/models/collection_model.dart';
import 'package:music_app/screens/user/user_controller.dart';
import 'package:music_app/widgets/widgets.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List<Artist> artistSamples = Artist.artistSamples;
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
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: Column(
            children: const [
              UserInformation(),
              SizedBox(height: 10),
              SelectionRow(),
              SizedBox(height: 10),
              // RecentPlaylist(collectionSamples: collectionSamples),
              // ArtistList(artistSamples: artistSamples)
            ],
          ),
        ),
      ),
    );
  }
}

class RecentPlaylist extends StatelessWidget {
  const RecentPlaylist({
    Key? key,
    required this.collectionSamples,
    required this.title,
  }) : super(key: key);

  final String title;
  final List<Collection> collectionSamples;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
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
    );
  }
}

class SelectionRow extends StatelessWidget {
  const SelectionRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        // IconButton(
        //   onPressed: () {},
        //   icon: const Icon(
        //     Icons.close,
        //     color: Colors.white,
        //   ),

        // ),
        FilterButton(text: 'Playlist'),
        SizedBox(width: 10),
        FilterButton(text: 'Albums'),
        SizedBox(width: 10),
        FilterButton(text: 'Artists'),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        shape: const StadiumBorder(),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        side: const BorderSide(color: Colors.white),
      ),
      onPressed: () {},
      child: Text(text),
    );
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
          ),
        ),
        const SizedBox(width: 15),
        Text(
          'Huynh Anh Kiet',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        )
      ],
    );
  }
}

// class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
//   const CustomAppBar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       leading: const Icon(Icons.grid_view_rounded),
//       actions: [
//         Container(
//           margin: const EdgeInsets.only(right: 20),
//           child: const CircleAvatar(
//             backgroundImage: NetworkImage(
//                 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'),
//           ),
//         )
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(100);
// }
