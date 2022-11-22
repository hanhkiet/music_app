import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/global/player_controller.dart';
import 'package:music_app/models/artist_model.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/services/firebase_firestore.dart';
import 'package:music_app/services/firebase_storage.dart';
import 'package:music_app/widgets/artist_listview.dart';
import 'package:music_app/widgets/player_button.dart';
import 'package:music_app/widgets/seekbar.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class SongScreen extends GetView<PlayerController> {
  const SongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _updatePlaylist();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: controller.audioPlayer.currentIndexStream,
        builder: (context, snapshot) {
          if (controller.getCurrentSong == null) {
            return const Center(
              child: Text('Null'),
            );
          }

          PageController pageController = PageController();

          final Song currentSong = controller.getCurrentSong!;
          FirestoreService.increasePlayCount(currentSong);

          return Stack(
            fit: StackFit.expand,
            children: [
              BackgroundFilter(
                song: controller.getCurrentSong!,
              ),
              PageView(
                scrollDirection: Axis.vertical,
                controller: pageController,
                children: [
                  MusicPlayer(
                    song: currentSong,
                    player: controller.audioPlayer,
                    pageController: pageController,
                  ),
                  ScreenInformation(song: currentSong),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  _updatePlaylist() async {
    final List<Song> songs = Get.arguments;
    if (songs.length > 1) {
      await controller.updatePlaylist(songs);
    } else if (songs.length == 1) {
      await controller.updateSong(songs[0]);
    }
  }
}

class ScreenInformation extends StatelessWidget {
  const ScreenInformation({
    Key? key,
    required this.song,
  }) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ActionRow(),
          const SizedBox(height: 20),
          ArtistList(artists: song.artists),
          const CurrentPlaylist(),
        ],
      ),
    );
  }
}

class CurrentPlaylist extends StatelessWidget {
  const CurrentPlaylist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Playlist',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}

class ArtistList extends StatelessWidget {
  const ArtistList({
    Key? key,
    required this.artists,
  }) : super(key: key);

  final List<Artist> artists;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Artists',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        ArtistListView(artists: artists),
      ],
    );
  }
}

class ActionRow extends StatelessWidget {
  const ActionRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ActionButton(
          title: 'Favorite',
          icon: const Icon(Icons.favorite_border_rounded),
          action: () {},
        ),
        ActionButton(
          title: 'Add to playlist',
          icon: const Icon(Icons.playlist_add_rounded),
          action: () {},
        ),
        ActionButton(
          title: 'Download',
          icon: const Icon(Icons.download_rounded),
          action: () {},
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.action,
  }) : super(key: key);

  final String title;
  final Icon icon;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: action,
          icon: icon,
          iconSize: 35,
          color: Colors.white,
        ),
        Text(
          title,
        ),
      ],
    );
  }
}

class BackgroundFilter extends StatelessWidget {
  const BackgroundFilter({
    Key? key,
    required this.song,
  }) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(1),
          ],
          stops: const [0, 0.3, 0.6],
        ).createShader(rect);
      },
      blendMode: BlendMode.darken,
      child: FutureBuilder(
        future: StorageService.getDownloadUrl('covers/${song.coverUrl}'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          String url = snapshot.data!;
          return CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }
}

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({
    Key? key,
    required this.song,
    required this.player,
    required this.pageController,
  }) : super(key: key);

  final Song song;
  final AudioPlayer player;
  final PageController pageController;

  Stream<SeekBarData> _getSeekBarDataStream(AudioPlayer audioPlayer) {
    return rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
        audioPlayer.positionStream, audioPlayer.durationStream,
        (Duration position, Duration? duration) {
      return SeekBarData(position, duration ?? Duration.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SongInformation(song: song),
          const SizedBox(height: 10),
          StreamBuilder<SeekBarData>(
            stream: _getSeekBarDataStream(player),
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                duration: positionData?.duration ?? Duration.zero,
                position: positionData?.position ?? Duration.zero,
                onChangedEnd: player.seek,
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RepeatButton(),
              const PlayerButton(),
              MoreFunctionButton(
                pageController: pageController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SongInformation extends StatelessWidget {
  const SongInformation({
    Key? key,
    required this.song,
  }) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: StorageService.getDownloadUrl('covers/${song.coverUrl}'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            String url = snapshot.data!;
            return CachedNetworkImage(
              imageUrl: url,
              imageBuilder: (context, imageProvider) => Container(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              placeholder: (context, url) => SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 30),
        Text(
          song.name,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class MoreFunctionButton extends StatelessWidget {
  const MoreFunctionButton({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 100),
        curve: Curves.bounceInOut,
      ),
      icon: const Icon(Icons.more_horiz),
      color: Colors.white,
      iconSize: 35,
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find();

    if (playerController.playlistLength == 1) {
      return Obx(() {
        if (playerController.loopMode.value == LoopMode.one) {
          return IconButton(
            onPressed: () => playerController.updateMode(LoopMode.off),
            icon: const Icon(
              Icons.repeat_one_rounded,
              color: Colors.white,
            ),
            iconSize: 35,
          );
        } else {
          return IconButton(
            onPressed: () => playerController.updateMode(LoopMode.one),
            icon: Icon(
              Icons.repeat_rounded,
              color: Colors.white.withOpacity(0.2),
            ),
            iconSize: 35,
          );
        }
      });
    }

    return Obx(() {
      if (playerController.loopMode.value == LoopMode.one) {
        return IconButton(
          onPressed: () => playerController.updateMode(LoopMode.all),
          icon: const Icon(
            Icons.repeat_one_rounded,
            color: Colors.white,
          ),
          iconSize: 35,
        );
      } else if (playerController.loopMode.value == LoopMode.all) {
        return IconButton(
          onPressed: () {
            playerController.updateMode(LoopMode.off);
            playerController.updateShuffleMode(needShuffle: true);
          },
          icon: const Icon(
            Icons.repeat_rounded,
            color: Colors.white,
          ),
          iconSize: 35,
        );
      } else if (playerController.shuffleMode.value) {
        return IconButton(
          onPressed: () => playerController.updateMode(LoopMode.one),
          icon: const Icon(
            Icons.shuffle_rounded,
            color: Colors.white,
          ),
          iconSize: 35,
        );
      } else {
        return IconButton(
          onPressed: () =>
              playerController.updateShuffleMode(needShuffle: true),
          icon: Icon(
            Icons.shuffle_rounded,
            color: Colors.white.withOpacity(.2),
          ),
          iconSize: 35,
        );
      }
    });
  }
}
