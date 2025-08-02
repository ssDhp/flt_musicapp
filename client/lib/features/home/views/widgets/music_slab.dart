import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/theme/app_pallet.dart';
import 'package:client/features/home/views/widgets/music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);
    final songNotifier = ref.read(currentSongNotifierProvider.notifier);
    if (currentSong == null) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MusicPlayer(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final tween =
                  Tween(begin: const Offset(0, 1), end: Offset.zero).chain(
                CurveTween(curve: Curves.easeIn),
              );
              final transitionAnimation = animation.drive(tween);

              return SlideTransition(
                position: transitionAnimation,
                child: child,
              );
            },
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 66,
            width: MediaQuery.of(context).size.width - 16,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 208, 88, 114),
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'music-image',
                        child: Container(
                          width: 48,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(currentSong.thumbnail_url),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentSong.song_name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              currentSong.artist,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Pallete.subtitleText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        color: Pallete.whiteColor,
                      ),
                    ),
                    IconButton(
                      onPressed: songNotifier.playPause,
                      icon: Icon(
                        songNotifier.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Pallete.whiteColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          StreamBuilder(
              stream: songNotifier.audioPlayer?.positionStream,
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }

                final position = asyncSnapshot.data;
                final duration = songNotifier.audioPlayer!.duration;
                double sliderValue = 0.0;
                if (position != null && duration != null) {
                  sliderValue =
                      position.inMilliseconds / duration.inMilliseconds;
                }

                return Positioned(
                  bottom: 0,
                  left: 8,
                  child: Container(
                    height: 2,
                    width:
                        sliderValue * (MediaQuery.of(context).size.width - 32),
                    decoration: const BoxDecoration(
                      color: Pallete.whiteColor,
                    ),
                  ),
                );
              }),
          Positioned(
            bottom: 0,
            left: 8,
            child: Container(
              height: 2,
              width: MediaQuery.of(context).size.width - 32,
              decoration: const BoxDecoration(
                color: Pallete.inactiveSeekColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
